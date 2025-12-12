import 'package:flutter/material.dart';

/// Admin panel screen for system administration.
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin-Panel'),
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
                          'Administration',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                        Text(
                          'System- und Benutzerverwaltung',
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
          _buildSectionHeader(context, 'Kategorien'),
          _buildAdminTile(
            context,
            icon: Icons.category,
            title: 'Kategorien verwalten',
            subtitle: 'Kategorien und Subkategorien erstellen',
            milestone: 4,
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(context, 'Slots'),
          _buildAdminTile(
            context,
            icon: Icons.confirmation_number,
            title: 'Slot-Varianten',
            subtitle: 'Slot-Typen und Preise konfigurieren',
            milestone: 4,
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(context, 'Zahlungen'),
          _buildAdminTile(
            context,
            icon: Icons.payment,
            title: 'Zahlungseinstellungen',
            subtitle: 'PayPal und Bitcoin für Slot-Käufe',
            milestone: 4,
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(context, 'Benutzer'),
          _buildAdminTile(
            context,
            icon: Icons.people,
            title: 'Benutzerverwaltung',
            subtitle: 'Benutzer verwalten und Rollen zuweisen',
            milestone: 11,
          ),
          _buildAdminTile(
            context,
            icon: Icons.report,
            title: 'Meldungen',
            subtitle: 'Gemeldete Angebote und Benutzer',
            milestone: 11,
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
    required int milestone,
  }) {
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
        trailing: Container(
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
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title wird in Meilenstein $milestone implementiert.'),
            ),
          );
        },
      ),
    );
  }
}
