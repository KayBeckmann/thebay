import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart' show client, authService;
import 'ban_user_dialog.dart';

/// Dialog showing user details with admin actions
class UserDetailDialog extends StatefulWidget {
  final User user;

  const UserDetailDialog({super.key, required this.user});

  @override
  State<UserDetailDialog> createState() => _UserDetailDialogState();
}

class _UserDetailDialogState extends State<UserDetailDialog> {
  late User _user;
  List<UserBanLog> _banHistory = [];
  bool _isLoadingHistory = false;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _loadBanHistory();
  }

  Future<void> _loadBanHistory() async {
    setState(() => _isLoadingHistory = true);
    try {
      final history =
          await client.userManagement.getBanHistory(_user.id!);
      if (mounted) {
        setState(() {
          _banHistory = history;
          _isLoadingHistory = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingHistory = false);
      }
    }
  }

  Future<void> _updateRole(UserRole newRole) async {
    final l10n = AppLocalizations.of(context)!;

    // Confirm if promoting to moderator or admin
    if (newRole == UserRole.moderator || newRole == UserRole.admin) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.warning),
          content: Text(
            l10n.confirmRoleChange(_getRoleText(newRole)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.confirm),
            ),
          ],
        ),
      );

      if (confirm != true) return;
    }

    try {
      final updated =
          await client.userManagement.updateUserRole(_user.id!, newRole);
      if (mounted) {
        setState(() => _user = updated);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.roleUpdated),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _grantFreeSlot() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      // Lade kostenlose Slot-Varianten
      final freeVariants = await client.slotVariant.getAll();
      final freeOnly = freeVariants.where((v) => v.isFree && v.isActive).toList();

      if (!mounted) return;

      if (freeOnly.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.noFreeSlotVariantsAvailable),
          ),
        );
        return;
      }

      // Zeige Auswahl-Dialog
      final selectedVariant = await showDialog<SlotVariant>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.card_giftcard),
          title: Text(l10n.grantFreeSlot),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.selectFreeSlotVariant(_user.username),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: freeOnly.length,
                    itemBuilder: (context, index) {
                      final variant = freeOnly[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.confirmation_number, color: Colors.green),
                          title: Text(variant.name),
                          subtitle: Text(l10n.daysRuntime(variant.durationDays)),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              l10n.freeUppercase,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          onTap: () => Navigator.pop(context, variant),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
          ],
        ),
      );

      if (selectedVariant == null) return;

      // Vergebe kostenlosen Slot
      await client.userSlot.grantFreeSlot(
        userId: _user.id!,
        slotVariantId: selectedVariant.id!,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.freeSlotGranted(selectedVariant.name, _user.username)),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _banUser() async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => const BanUserDialog(),
    );

    if (reason == null) return;

    final l10n = AppLocalizations.of(context)!;

    try {
      final updated = await client.userManagement.banUser(_user.id!, reason);
      if (mounted) {
        setState(() => _user = updated);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.userBanned),
            backgroundColor: Colors.green,
          ),
        );
        _loadBanHistory();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _unbanUser() async {
    final l10n = AppLocalizations.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.unbanUser),
        content: Text(l10n.confirmUnban),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.unbanUser),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final updated = await client.userManagement.unbanUser(
        _user.id!,
        l10n.unbanReason,
      );
      if (mounted) {
        setState(() => _user = updated);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.userUnbanned),
            backgroundColor: Colors.green,
          ),
        );
        _loadBanHistory();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.error(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOwnAccount = authService.currentUser?.userId == _user.id;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    child: Text(
                      _user.username.substring(0, 1).toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _user.username,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.userId(_user.id!),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withValues(alpha: 0.7),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoSection(),
                    const SizedBox(height: 20),
                    _buildRoleSection(isOwnAccount),
                    const SizedBox(height: 20),
                    if (!isOwnAccount) _buildActionsSection(),
                    if (_banHistory.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildBanHistorySection(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.information,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, l10n.createdAt,
                _formatDate(_user.createdAt)),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.login,
              l10n.lastLogin,
              _user.lastLoginAt != null
                  ? _formatDate(_user.lastLoginAt!)
                  : l10n.never,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.check_circle,
              l10n.status,
              _user.isActive ? l10n.active : l10n.inactive,
            ),
            if (_user.isBanned) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.block,
                l10n.bannedSince,
                _user.bannedAt != null ? _formatDate(_user.bannedAt!) : '-',
              ),
              if (_user.bannedReason != null) ...[
                const SizedBox(height: 8),
                _buildInfoRow(Icons.info, l10n.banReasonLabel, _user.bannedReason!),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSection(bool isOwnAccount) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.role,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            if (isOwnAccount)
              Text(
                l10n.cannotChangeOwnRole,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
            else
              ...UserRole.values.map((role) {
                return RadioListTile<UserRole>(
                  title: Text(_getRoleText(role)),
                  subtitle: Text(_getRoleDescription(role)),
                  value: role,
                  groupValue: _user.role,
                  onChanged: (value) {
                    if (value != null) {
                      _updateRole(value);
                    }
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection() {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.actions,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _grantFreeSlot,
                icon: const Icon(Icons.card_giftcard),
                label: Text(l10n.grantFreeSlot),
              ),
            ),
            const SizedBox(height: 8),
            if (_user.isBanned)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _unbanUser,
                  icon: const Icon(Icons.lock_open),
                  label: Text(l10n.unbanUser),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _banUser,
                  icon: const Icon(Icons.block),
                  label: Text(l10n.banUser),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanHistorySection() {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.banHistory,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            if (_isLoadingHistory)
              const Center(child: CircularProgressIndicator())
            else
              ..._banHistory.map((log) {
                final isBan = log.action == 'ban';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        isBan ? Icons.block : Icons.lock_open,
                        size: 16,
                        color: isBan ? Colors.red : Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isBan ? l10n.bannedAction : l10n.unbannedAction,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isBan ? Colors.red : Colors.green,
                                  ),
                            ),
                            if (log.reason != null)
                              Text(
                                log.reason!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            Text(
                              _formatDate(log.createdAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  String _getRoleText(UserRole role) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case UserRole.admin:
        return l10n.roleAdmin;
      case UserRole.moderator:
        return l10n.roleModerator;
      case UserRole.user:
        return l10n.roleUser;
    }
  }

  String _getRoleDescription(UserRole role) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case UserRole.admin:
        return l10n.roleDescriptionAdmin;
      case UserRole.moderator:
        return l10n.roleDescriptionModerator;
      case UserRole.user:
        return l10n.roleDescriptionUser;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day.$month.$year $hour:$minute';
  }
}
