import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:argon2/argon2.dart';

/// Service for password hashing and validation using Argon2id.
class PasswordService {
  // Argon2id parameters (OWASP recommended)
  static const int _memoryCost = 65536; // 64 MB
  static const int _timeCost = 3; // 3 iterations
  static const int _parallelism = 4; // 4 parallel threads
  static const int _hashLength = 32; // 32 bytes output
  static const int _saltLength = 16; // 16 bytes salt

  /// Minimum password length
  static const int minPasswordLength = 8;

  /// Validates password requirements:
  /// - Minimum 8 characters
  /// - At least one uppercase letter
  /// - At least one lowercase letter
  /// - At least one digit
  static PasswordValidationResult validatePassword(String password) {
    final errors = <String>[];

    if (password.length < minPasswordLength) {
      errors.add('Password must be at least $minPasswordLength characters');
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      errors.add('Password must contain at least one uppercase letter');
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      errors.add('Password must contain at least one lowercase letter');
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      errors.add('Password must contain at least one digit');
    }

    return PasswordValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Generates a cryptographically secure random salt.
  static Uint8List _generateSalt() {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(_saltLength, (_) => random.nextInt(256)),
    );
  }

  /// Hashes a password using Argon2id.
  /// Returns a string in the format: `$argon2id$v=19$m=65536,t=3,p=4$salt$hash`
  static Future<String> hashPassword(String password) async {
    final salt = _generateSalt();
    final saltBase64 = base64Encode(salt);

    final parameters = Argon2Parameters(
      Argon2Parameters.ARGON2_id,
      salt,
      version: Argon2Parameters.ARGON2_VERSION_13,
      iterations: _timeCost,
      memory: _memoryCost,
      lanes: _parallelism,
    );

    final argon2 = Argon2BytesGenerator();
    argon2.init(parameters);

    final passwordBytes = utf8.encode(password);
    final result = Uint8List(_hashLength);
    argon2.generateBytes(Uint8List.fromList(passwordBytes), result);

    final hashBase64 = base64Encode(result);

    // Return in PHC string format
    return '\$argon2id\$v=19\$m=$_memoryCost,t=$_timeCost,p=$_parallelism\$$saltBase64\$$hashBase64';
  }

  /// Verifies a password against a stored hash.
  static Future<bool> verifyPassword(String password, String storedHash) async {
    try {
      // Parse the stored hash
      final parts = storedHash.split('\$');
      if (parts.length != 6 || parts[1] != 'argon2id') {
        return false;
      }

      // Parse parameters
      final params = parts[3].split(',');
      final memory = int.parse(params[0].substring(2)); // m=
      final iterations = int.parse(params[1].substring(2)); // t=
      final parallelism = int.parse(params[2].substring(2)); // p=

      final salt = base64Decode(parts[4]);
      final storedHashBytes = base64Decode(parts[5]);

      final parameters = Argon2Parameters(
        Argon2Parameters.ARGON2_id,
        Uint8List.fromList(salt),
        version: Argon2Parameters.ARGON2_VERSION_13,
        iterations: iterations,
        memory: memory,
        lanes: parallelism,
      );

      final argon2 = Argon2BytesGenerator();
      argon2.init(parameters);

      final passwordBytes = utf8.encode(password);
      final computedHash = Uint8List(storedHashBytes.length);
      argon2.generateBytes(Uint8List.fromList(passwordBytes), computedHash);

      // Constant-time comparison to prevent timing attacks
      if (computedHash.length != storedHashBytes.length) {
        return false;
      }

      var result = 0;
      for (var i = 0; i < computedHash.length; i++) {
        result |= computedHash[i] ^ storedHashBytes[i];
      }

      return result == 0;
    } catch (e) {
      return false;
    }
  }
}

/// Result of password validation.
class PasswordValidationResult {
  final bool isValid;
  final List<String> errors;

  PasswordValidationResult({
    required this.isValid,
    required this.errors,
  });
}
