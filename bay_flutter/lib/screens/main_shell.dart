import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'dashboard_screen.dart';
import 'messages_screen.dart';
import 'search_screen.dart';
import 'sell_screen.dart';
import 'settings_screen.dart';
import 'admin/news_screen.dart';
import 'admin/admin_panel_screen.dart';

/// Navigation item configuration.
class NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget screen;
  final bool adminOnly;
  final bool moderatorOnly;

  const NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.screen,
    this.adminOnly = false,
    this.moderatorOnly = false,
  });
}

/// Main navigation shell with bottom navigation bar.
class MainShell extends StatefulWidget {
  final AuthService authService;
  final VoidCallback onLogout;

  const MainShell({
    super.key,
    required this.authService,
    required this.onLogout,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  List<NavItem> get _navItems {
    final user = widget.authService.currentUser;
    final isAdmin = user?.role == UserRole.admin;

    final items = <NavItem>[
      NavItem(
        label: 'Dashboard',
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        screen: DashboardScreen(authService: widget.authService),
      ),
      NavItem(
        label: 'Nachrichten',
        icon: Icons.mail_outline,
        selectedIcon: Icons.mail,
        screen: const MessagesScreen(),
      ),
      NavItem(
        label: 'Suchen',
        icon: Icons.search_outlined,
        selectedIcon: Icons.search,
        screen: const SearchScreen(),
      ),
      NavItem(
        label: 'Verkaufen',
        icon: Icons.add_circle_outline,
        selectedIcon: Icons.add_circle,
        screen: const SellScreen(),
      ),
      NavItem(
        label: 'Einstellungen',
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        screen: SettingsScreen(
          authService: widget.authService,
          onLogout: widget.onLogout,
        ),
      ),
    ];

    // Admin-only items
    if (isAdmin) {
      items.add(NavItem(
        label: 'News',
        icon: Icons.newspaper_outlined,
        selectedIcon: Icons.newspaper,
        screen: const NewsManagementScreen(),
        adminOnly: true,
      ));
      items.add(NavItem(
        label: 'Admin',
        icon: Icons.admin_panel_settings_outlined,
        selectedIcon: Icons.admin_panel_settings,
        screen: const AdminPanelScreen(),
        adminOnly: true,
      ));
    }

    return items;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navItems = _navItems;
    final user = widget.authService.currentUser;

    // Ensure selected index is valid
    if (_selectedIndex >= navItems.length) {
      _selectedIndex = 0;
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: navItems.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: navItems.map((item) {
          return NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: item.label,
          );
        }).toList(),
      ),
      drawer: _buildDrawer(context, user),
    );
  }

  Widget _buildDrawer(BuildContext context, AuthResponse? user) {
    final isAdmin = user?.role == UserRole.admin;

    return NavigationDrawer(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        Navigator.pop(context);
        _onItemTapped(index);
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.username ?? 'User',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      _getRoleName(user?.role),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
          child: Divider(),
        ),
        ..._navItems.take(5).map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: Text(item.label),
            )),
        if (isAdmin) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 8),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 16, 8),
            child: Text(
              'Administration',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          ..._navItems.skip(5).map((item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon),
                label: Text(item.label),
              )),
        ],
      ],
    );
  }

  String _getRoleName(UserRole? role) {
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.moderator:
        return 'Moderator';
      case UserRole.user:
      default:
        return 'Benutzer';
    }
  }
}
