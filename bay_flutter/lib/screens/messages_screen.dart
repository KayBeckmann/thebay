import 'package:flutter/material.dart';

/// Messages screen for viewing and sending messages.
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nachrichten'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // TODO: Compose new message
            },
            tooltip: 'Neue Nachricht',
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(text: 'Posteingang'),
                Tab(text: 'Gesendet'),
                Tab(text: 'Entwürfe'),
              ],
              labelColor: Theme.of(context).colorScheme.primary,
              indicatorColor: Theme.of(context).colorScheme.primary,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildEmptyState(
                    context,
                    Icons.inbox_outlined,
                    'Keine Nachrichten',
                    'Dein Posteingang ist leer.',
                  ),
                  _buildEmptyState(
                    context,
                    Icons.send_outlined,
                    'Keine gesendeten Nachrichten',
                    'Du hast noch keine Nachrichten gesendet.',
                  ),
                  _buildEmptyState(
                    context,
                    Icons.drafts_outlined,
                    'Keine Entwürfe',
                    'Du hast keine gespeicherten Entwürfe.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Compose new message
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
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
