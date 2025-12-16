import 'dart:async';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/pgp_key_service.dart';

/// Registration screen with Material Design.
class RegisterScreen extends StatefulWidget {
  final AuthService authService;
  final PgpKeyService pgpKeyService;
  final VoidCallback onRegisterSuccess;
  final VoidCallback onNavigateToLogin;

  const RegisterScreen({
    super.key,
    required this.authService,
    required this.pgpKeyService,
    required this.onRegisterSuccess,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (value.length > 20) {
      return 'Username must be at most 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Only letters, numbers, and underscores allowed';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain a lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a digit';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedTerms) {
      setState(() {
        _errorMessage = 'You must accept the terms of service';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await widget.authService.register(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        acceptedTerms: _acceptedTerms,
      );

      if (!mounted) return;

      if (response.success) {
        // Generiere PGP-Schlüssel nach erfolgreicher Registrierung
        await _generatePgpKeyAfterRegistration(
          username: _usernameController.text.trim(),
        );
      } else {
        setState(() {
          _errorMessage = response.errorMessage ?? 'Registration failed';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Connection error. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _generatePgpKeyAfterRegistration({
    required String username,
  }) async {
    // Zeige Progress-Dialog für Key-Generierung
    _showKeyGeneratingDialog();

    try {
      // Generiere Schlüsselpaar (läuft im Isolate)
      final keyPair = await widget.pgpKeyService.generateKeyPair(
        name: username,
        email: '$username@bay.local',
      );

      // Speichere Private Key lokal
      await widget.pgpKeyService.storePrivateKey(
        keyPair.privateKey,
        keyPair.fingerprint,
      );

      // Lade Public Key zum Server hoch
      await widget.pgpKeyService.uploadPublicKey(
        keyPair.publicKey,
        keyPair.identity,
        keyPair.fingerprint,
        keyPair.algorithm,
        keyPair.keySize,
      );

      // Schließe Progress-Dialog
      if (mounted) Navigator.of(context).pop();

      // Registrierung erfolgreich abgeschlossen
      widget.onRegisterSuccess();
    } catch (e) {
      // Schließe Progress-Dialog bei Fehler
      if (mounted) Navigator.of(context).pop();

      // Zeige Fehler, aber fahre trotzdem fort (Key kann später generiert werden)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Schlüssel konnte nicht generiert werden: $e\n'
              'Du kannst ihn später in den Einstellungen erstellen.',
            ),
            duration: const Duration(seconds: 5),
          ),
        );
        // Trotzdem fortfahren, da Registrierung erfolgreich war
        widget.onRegisterSuccess();
      }
    }
  }

  void _showKeyGeneratingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(height: 24),
              Text(
                'Sicherheitsschlüssel wird erstellt...',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Dein persönlicher Verschlüsselungsschlüssel wird generiert.\n'
                'Dies dauert ca. 10-30 Sekunden.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              const _KeyGeneratingTimer(),
            ],
          ),
        ),
      ),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                '1. Acceptance of Terms\n\n'
                'By accessing and using this platform, you accept and agree to be bound by the terms and provision of this agreement.\n\n'
                '2. User Conduct\n\n'
                'Users agree to use this platform only for lawful purposes. You are prohibited from posting or transmitting any unlawful, threatening, defamatory, or otherwise objectionable material.\n\n'
                '3. Account Security\n\n'
                'You are responsible for maintaining the confidentiality of your account credentials. You agree to notify us immediately of any unauthorized use of your account.\n\n'
                '4. Privacy\n\n'
                'We respect your privacy. We do not collect email addresses or unnecessary personal information. Your username and password are the only required account details.\n\n'
                '5. Content\n\n'
                'Users are solely responsible for the content they post. We reserve the right to remove any content that violates these terms.\n\n'
                '6. Transactions\n\n'
                'All transactions are between users. This platform does not act as an intermediary or escrow service. Users are responsible for their own transactions.\n\n'
                '7. Limitation of Liability\n\n'
                'This platform is provided "as is" without any warranties. We are not liable for any damages arising from your use of this platform.\n\n'
                '8. Changes to Terms\n\n'
                'We reserve the right to modify these terms at any time. Continued use of the platform constitutes acceptance of the modified terms.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo/Title
                    Icon(
                      Icons.storefront,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign up to get started',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Error message
                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red[700]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red[700]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Username field
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                        helperText: '3-20 characters, letters, numbers, underscores',
                      ),
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      validator: _validateUsername,
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        helperText: 'Min 8 chars, uppercase, lowercase, digit',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),

                    // Confirm password field
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleRegister(),
                      validator: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 16),

                    // Terms of service checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptedTerms,
                          onChanged: (value) {
                            setState(() {
                              _acceptedTerms = value ?? false;
                              if (_acceptedTerms) {
                                _errorMessage = null;
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _acceptedTerms = !_acceptedTerms;
                                if (_acceptedTerms) {
                                  _errorMessage = null;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Wrap(
                                children: [
                                  const Text('I agree to the '),
                                  GestureDetector(
                                    onTap: _showTermsDialog,
                                    child: Text(
                                      'Terms of Service',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Register button
                    FilledButton(
                      onPressed: _isLoading ? null : _handleRegister,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                    const SizedBox(height: 16),

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: widget.onNavigateToLogin,
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget das die verstrichene Zeit während der Key-Generierung anzeigt.
class _KeyGeneratingTimer extends StatefulWidget {
  const _KeyGeneratingTimer();

  @override
  State<_KeyGeneratingTimer> createState() => _KeyGeneratingTimerState();
}

class _KeyGeneratingTimerState extends State<_KeyGeneratingTimer> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _seconds ~/ 60;
    final secs = _seconds % 60;
    return Text(
      'Verstrichene Zeit: ${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
