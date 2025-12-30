import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../main.dart' show client;
import '../services/auth_service.dart';
import '../services/pgp_key_service.dart';
import '../services/message_service.dart';
import 'dashboard_screen.dart';
import 'messages_screen.dart';
import 'search_screen.dart';
import 'sell_screen.dart';
import 'settings_screen.dart';
import 'transactions/transactions_screen.dart';
import 'admin/news_screen.dart';
import 'admin/admin_panel_screen.dart';
import 'moderator/moderator_panel_screen.dart';

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
  final PgpKeyService pgpKeyService;
  final MessageService messageService;
  final VoidCallback onLogout;

  const MainShell({
    super.key,
    required this.authService,
    required this.pgpKeyService,
    required this.messageService,
    required this.onLogout,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  int _unreadCount = 0;
  int _openReportsCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUnreadCount();
    _loadOpenReportsCount();
  }

  Future<void> _loadUnreadCount() async {
    try {
      final count = await widget.messageService.getUnreadCount();
      if (mounted) {
        setState(() => _unreadCount = count);
      }
    } catch (e) {
      // Ignore errors
    }
  }

  Future<void> _loadOpenReportsCount() async {
    final user = widget.authService.currentUser;
    final isModerator = user?.role == UserRole.moderator || user?.role == UserRole.admin;

    if (!isModerator) return;

    try {
      final count = await client.report.getOpenCount();
      if (mounted) {
        setState(() => _openReportsCount = count);
      }
    } catch (e) {
      // Ignore errors
    }
  }

  /// Aktualisiert den Unread-Counter (wird von MessagesScreen aufgerufen).
  void refreshUnreadCount() {
    _loadUnreadCount();
  }

  List<NavItem> _getNavItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = widget.authService.currentUser;
    final isAdmin = user?.role == UserRole.admin;
    final isModerator = user?.role == UserRole.moderator || isAdmin;

    final items = <NavItem>[
      NavItem(
        label: l10n.navDashboard,
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        screen: DashboardScreen(authService: widget.authService),
      ),
      NavItem(
        label: l10n.navMessages,
        icon: Icons.mail_outline,
        selectedIcon: Icons.mail,
        screen: MessagesScreen(
          messageService: widget.messageService,
          pgpKeyService: widget.pgpKeyService,
          onUnreadCountChanged: _loadUnreadCount,
        ),
      ),
      NavItem(
        label: l10n.navSearch,
        icon: Icons.search_outlined,
        selectedIcon: Icons.search,
        screen: const SearchScreen(),
      ),
      NavItem(
        label: l10n.navSell,
        icon: Icons.add_circle_outline,
        selectedIcon: Icons.add_circle,
        screen: const SellScreen(),
      ),
      NavItem(
        label: l10n.navTransactions,
        icon: Icons.receipt_long_outlined,
        selectedIcon: Icons.receipt_long,
        screen: const TransactionsScreen(),
      ),
      NavItem(
        label: l10n.navSettings,
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        screen: SettingsScreen(
          authService: widget.authService,
          pgpKeyService: widget.pgpKeyService,
          onLogout: widget.onLogout,
        ),
      ),
    ];

    // Moderator and Admin items
    if (isModerator) {
      items.add(NavItem(
        label: l10n.navModeration,
        icon: Icons.shield_outlined,
        selectedIcon: Icons.shield,
        screen: const ModeratorPanelScreen(),
        moderatorOnly: true,
      ));
    }

    // Admin-only items
    if (isAdmin) {
      items.add(NavItem(
        label: l10n.navNews,
        icon: Icons.newspaper_outlined,
        selectedIcon: Icons.newspaper,
        screen: const NewsManagementScreen(),
        adminOnly: true,
      ));
      items.add(NavItem(
        label: l10n.navAdmin,
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
    final navItems = _getNavItems(context);
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
        destinations: navItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          // Badge für Nachrichten (Index 1)
          if (index == 1 && _unreadCount > 0) {
            return NavigationDestination(
              icon: Badge(
                label: Text(_unreadCount > 99 ? '99+' : '$_unreadCount'),
                child: Icon(item.icon),
              ),
              selectedIcon: Badge(
                label: Text(_unreadCount > 99 ? '99+' : '$_unreadCount'),
                child: Icon(item.selectedIcon),
              ),
              label: item.label,
            );
          }

          // Badge für Moderation (moderatorOnly items)
          if (item.moderatorOnly && _openReportsCount > 0) {
            return NavigationDestination(
              icon: Badge(
                label: Text(_openReportsCount > 99 ? '99+' : '$_openReportsCount'),
                child: Icon(item.icon),
              ),
              selectedIcon: Badge(
                label: Text(_openReportsCount > 99 ? '99+' : '$_openReportsCount'),
                child: Icon(item.selectedIcon),
              ),
              label: item.label,
            );
          }

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
    final l10n = AppLocalizations.of(context)!;
    final isAdmin = user?.role == UserRole.admin;
    final isModerator = user?.role == UserRole.moderator || isAdmin;

    // Separate items by type
    final navItems = _getNavItems(context);
    final basicItems = navItems.take(6).toList();
    final moderatorItems = navItems.skip(6).where((item) => item.moderatorOnly && !item.adminOnly).toList();
    final adminItems = navItems.where((item) => item.adminOnly).toList();

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
                      user?.username ?? l10n.drawerUserFallback,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      _getRoleName(context, user?.role),
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
        ...basicItems.map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: Text(item.label),
            )),
        if (isModerator && moderatorItems.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 8),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 16, 8),
            child: Text(
              l10n.drawerModerationSection,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          ...moderatorItems.map((item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon),
                label: Text(item.label),
              )),
        ],
        if (isAdmin && adminItems.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 8),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 16, 8),
            child: Text(
              l10n.drawerAdminSection,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          ...adminItems.map((item) => NavigationDrawerDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon),
                label: Text(item.label),
              )),
        ],
      ],
    );
  }

  String _getRoleName(BuildContext context, UserRole? role) {
    final l10n = AppLocalizations.of(context)!;
    switch (role) {
      case UserRole.admin:
        return l10n.roleAdmin;
      case UserRole.moderator:
        return l10n.roleModerator;
      case UserRole.user:
      default:
        return l10n.roleUser;
    }
  }
}
