import 'package:flutter/material.dart';
import '../main.dart';
import 'login_screen.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Choose Your Role',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'How would you like to use HomeServe?',
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.textMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // Customer Card
              _RoleCard(
                icon: Icons.person_rounded,
                iconColor: AppTheme.primary,
                iconBg: const Color(0xFFDCEAFD),
                title: 'Continue as Customer',
                subtitle:
                    'Book home services, track your bookings, and manage your profile.',
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A6FE0), Color(0xFF0D4FAA)],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                isPrimary: true,
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // Provider card (grayed out / not available)
              const _RoleCard(
                icon: Icons.home_repair_service_rounded,
                iconColor: AppTheme.textLight,
                iconBg: Color(0xFFF3F4F6),
                title: 'Service Provider',
                subtitle:
                    'Provider features are not available yet. Stay tuned!',
                gradient: LinearGradient(
                  colors: [Color(0xFFD1D5DB), Color(0xFF9CA3AF)],
                ),
                onTap: null,
                isPrimary: false,
              ),

              const Spacer(),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: AppTheme.textLight,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback? onTap;
  final bool isPrimary;

  const _RoleCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: isPrimary ? gradient : null,
            color: isDisabled ? const Color(0xFFF9FAFB) : null,
            borderRadius: BorderRadius.circular(20),
            border: isDisabled
                ? Border.all(color: const Color(0xFFE5E7EB))
                : null,
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isPrimary
                      ? Colors.white.withOpacity(0.2)
                      : iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: isPrimary ? Colors.white : iconColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: isPrimary ? Colors.white : AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: isPrimary
                            ? Colors.white.withOpacity(0.8)
                            : AppTheme.textMedium,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isDisabled)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isPrimary ? Colors.white : AppTheme.textLight,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}