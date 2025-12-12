import 'package:flutter/material.dart';

import '../services/auth_service.dart';

/// Dashboard screen showing news and recent listings.
class DashboardScreen extends StatefulWidget {
  final AuthService authService;

  const DashboardScreen({
    super.key,
    required this.authService,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final user = widget.authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Welcome message
            _buildWelcomeCard(context, user?.username),
            const SizedBox(height: 16),

            // News section
            _buildSectionHeader(context, 'Neuigkeiten'),
            const SizedBox(height: 8),
            _buildNewsSection(context),
            const SizedBox(height: 24),

            // Slot warnings section
            _buildSectionHeader(context, 'Slot-Warnungen'),
            const SizedBox(height: 8),
            _buildSlotWarningsSection(context),
            const SizedBox(height: 24),

            // Recent listings section
            _buildSectionHeader(context, 'Neueste Angebote'),
            const SizedBox(height: 8),
            _buildRecentListingsSection(context),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    // TODO: Refresh data from server
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Widget _buildWelcomeCard(BuildContext context, String? username) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.waving_hand,
                size: 28,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Willkommen, ${username ?? 'Benutzer'}!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Was möchtest du heute tun?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to full list
          },
          child: const Text('Alle anzeigen'),
        ),
      ],
    );
  }

  Widget _buildNewsSection(BuildContext context) {
    // TODO: Load news from server
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.campaign,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Keine Neuigkeiten',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Aktuell gibt es keine Neuigkeiten. Schau später wieder vorbei!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotWarningsSection(BuildContext context) {
    // TODO: Load slot warnings from server
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Keine Slots laufen in den nächsten 3 Tagen ab.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentListingsSection(BuildContext context) {
    // TODO: Load recent listings from server
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Noch keine Angebote',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Hier werden die neuesten Angebote angezeigt.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
