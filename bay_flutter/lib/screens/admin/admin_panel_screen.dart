import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'categories_screen.dart';
import 'slot_variants_screen.dart';
import 'payment_settings_screen.dart';
import 'pending_payments_screen.dart';
import 'user_management_screen.dart';

/// Admin panel screen for system administration.
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminPanel),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    size: 32,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.administration,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                        Text(
                          l10n.systemUserManagement,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Admin sections
          _buildSectionHeader(context, l10n.categories),
          _buildAdminTile(
            context,
            icon: Icons.category,
            title: l10n.manageCategories,
            subtitle: l10n.createCategoriesSubcategories,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CategoriesScreen()),
            ),
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(context, l10n.slots),
          _buildAdminTile(
            context,
            icon: Icons.confirmation_number,
            title: l10n.slotVariants,
            subtitle: l10n.configureSlotTypes,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SlotVariantsScreen()),
            ),
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(context, l10n.payments),
          _buildAdminTile(
            context,
            icon: Icons.payment,
            title: l10n.paymentSettings,
            subtitle: l10n.paypalBitcoinSlots,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaymentSettingsScreen()),
            ),
          ),
          _buildAdminTile(
            context,
            icon: Icons.pending_actions,
            title: l10n.pendingPayments,
            subtitle: l10n.reviewPendingOrders,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PendingPaymentsScreen()),
            ),
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(context, l10n.users),
          _buildAdminTile(
            context,
            icon: Icons.people,
            title: l10n.userManagement,
            subtitle: l10n.manageUsersRoles,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserManagementScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildAdminTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    int? milestone,
  }) {
    final isImplemented = onTap != null;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: milestone != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'M$milestone',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                ),
              )
            : const Icon(Icons.chevron_right),
        onTap: isImplemented
            ? onTap
            : () {
                final l10n = AppLocalizations.of(context)!;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.featureInMilestone(title, milestone.toString())),
                  ),
                );
              },
      ),
    );
  }
}
