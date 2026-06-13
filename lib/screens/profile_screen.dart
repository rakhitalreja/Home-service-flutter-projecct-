import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/app_scaffold.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  /// [standalone] = true  → wrapped in AppScaffold with bottom nav
  /// [standalone] = false → embedded inside HomeScreen's body (no extra Scaffold)
  final bool standalone;
  const ProfileScreen({super.key, this.standalone = true});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final user = appState.currentUser;
    final bookingCount = appState.bookings.length;

    final content = Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('My Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppTheme.primary, AppTheme.primaryDark],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 3),
                    ),
                    child: Center(
                      child: Text(
                        user?.name.isNotEmpty == true
                            ? user!.name[0].toUpperCase()
                            : 'C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user?.name ?? 'Customer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? 'customer@example.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatChip(
                        label: 'Bookings',
                        value: '$bookingCount',
                        icon: Icons.calendar_today_rounded,
                      ),
                      const SizedBox(width: 16),
                      const _StatChip(
                        label: 'Saved',
                        value: '4',
                        icon: Icons.favorite_rounded,
                      ),
                      const SizedBox(width: 16),
                      const _StatChip(
                        label: 'Reviews',
                        value: '2',
                        icon: Icons.star_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _SectionLabel('Account'),
                  _MenuItem(
                    icon: Icons.person_outline_rounded,
                    label: 'Edit Profile',
                    subtitle: 'Update your personal info',
                    onTap: () => _showEditProfileSheet(context),
                  ),
                  _MenuItem(
                    icon: Icons.location_on_outlined,
                    label: 'Saved Addresses',
                    subtitle: 'Manage your saved locations',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    subtitle: 'Manage notification preferences',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _SectionLabel('Support'),
                  _MenuItem(
                    icon: Icons.help_outline_rounded,
                    label: 'Help & Support',
                    subtitle: 'Get help from our team',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.privacy_tip_outlined,
                    label: 'Privacy Policy',
                    subtitle: 'Read our privacy policy',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.star_outline_rounded,
                    label: 'Rate the App',
                    subtitle: 'Tell us what you think',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F1),
                      borderRadius: BorderRadius.circular(16),
                      border:
                      Border.all(color: Colors.red.withOpacity(0.2)),
                    ),
                    child: ListTile(
                      onTap: () => _logout(context),
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.logout_rounded,
                            color: Colors.red, size: 22),
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: const Text(
                        'Sign out of your account',
                        style: TextStyle(
                            color: Colors.red, fontSize: 12, height: 1.3),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded,
                          color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'HomeServe v1.0.0',
                    style:
                    TextStyle(color: AppTheme.textLight, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (!standalone) return content;

    return AppScaffold(
      currentIndex: 2,
      showDrawer: false,
      body: content,
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  void _showEditProfileSheet(BuildContext context) {
    final user = AppState.of(context).currentUser;
    final nameCtrl = TextEditingController(text: user?.name ?? '');
    final emailCtrl = TextEditingController(text: user?.email ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sub-widgets ─────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatChip(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.textLight,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFDCEAFD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 22),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppTheme.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.textLight,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppTheme.textLight),
      ),
    );
  }
}
