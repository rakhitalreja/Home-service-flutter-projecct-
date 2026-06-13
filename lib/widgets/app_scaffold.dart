import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/home_screen.dart';
import '../screens/bookings_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';
import '../screens/services/services_screen.dart';
import '../screens/bookings/bookings_api_screen.dart';

/// Shared bottom nav + drawer wrapper used by every screen.
/// [currentIndex]: 0 = Home, 1 = Bookings, 2 = Profile.
/// [child]: the page body (should NOT include its own Scaffold when wrapped).
/// For screens that have their own Scaffold (like HomeScreen's IndexedStack),
/// pass [useOwnScaffold] = true and the bottom nav will be injected.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final AppBar? appBar;
  final bool showDrawer;

  const AppScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    this.appBar,
    this.showDrawer = false,
  });

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget destination;
    switch (index) {
      case 0:
        destination = const HomeScreen();
        break;
      case 1:
        destination = const BookingsScreen(standalone: true);
        break;
      case 2:
        destination = const ProfileScreen(standalone: true);
        break;
      default:
        return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => destination),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final user = appState.currentUser;
    final userName = user?.name ?? 'Customer';

    return Scaffold(
      appBar: appBar,
      drawer: showDrawer ? _AppDrawer(userName: userName, userEmail: user?.email ?? '') : null,
      body: body,
      bottomNavigationBar: _BottomNav(
        currentIndex: currentIndex,
        onTap: (i) => _onTabTapped(context, i),
      ),
    );
  }
}

// ─── Bottom Navigation Bar ───────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textLight,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today_rounded),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ─── Drawer ──────────────────────────────────────────────────────────────────

class _AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;

  const _AppDrawer({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.primary, AppTheme.primaryDark],
              ),
            ),
            accountName: Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            accountEmail: Text(
              userEmail.isNotEmpty ? userEmail : 'customer@example.com',
              style: const TextStyle(fontSize: 13),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.25),
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'C',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
              ),
            ),
          ),

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.calendar_today_rounded,
                  label: 'My Bookings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BookingsScreen(standalone: true)),
                          (route) => false,
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.person_rounded,
                  label: 'My Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ProfileScreen(standalone: true)),
                          (route) => false,
                    );
                  },
                ),
                const Divider(indent: 16, endIndent: 16),
                _DrawerItem(
                  icon: Icons.home_repair_service_rounded,
                  label: 'Manage Services',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ServicesScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.calendar_today_rounded,
                  label: 'Manage Bookings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingsApiScreen(),
                      ),
                    );
                  },
                ),
                _DrawerItem(
                  icon: Icons.location_on_outlined,
                  label: 'Saved Addresses',
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications',
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Support',
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  icon: Icons.star_outline_rounded,
                  label: 'Rate the App',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(indent: 16, endIndent: 16),
                _DrawerItem(
                  icon: Icons.logout_rounded,
                  label: 'Logout',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    _confirmLogout(context);
                  },
                ),
              ],
            ),
          ),

          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'HomeServe v1.0.0',
              style: const TextStyle(color: AppTheme.textLight, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppTheme.textMedium)),
          ),
          ElevatedButton(
            onPressed: () {
              AppState.of(context).clearUser();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.textDark;
    return ListTile(
      leading: Icon(icon, color: c, size: 22),
      title: Text(
        label,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 8,
    );
  }
}
