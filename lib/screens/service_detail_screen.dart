import 'package:flutter/material.dart';
import '../main.dart';
import '../models/service_model.dart';
import '../widgets/app_scaffold.dart';
import 'booking_screen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentIndex: 0,
      showDrawer: false,
      body: Scaffold(
        backgroundColor: AppTheme.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 240,
              pinned: true,
              backgroundColor: service.color,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_rounded,
                      color: Colors.white),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: service.lightColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: service.color.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(service.icon,
                            color: service.color, size: 52),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        service.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: service.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: service.lightColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.currency_rupee_rounded,
                                  color: service.color, size: 18),
                              Text(
                                service.priceLabel,
                                style: TextStyle(
                                  color: service.color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star_rounded,
                                  color: Color(0xFFF59E0B), size: 18),
                              SizedBox(width: 4),
                              Text(
                                '4.8 (120+ reviews)',
                                style: TextStyle(
                                  color: Color(0xFFF59E0B),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'About This Service',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      service.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textMedium,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'What\'s Included',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._features.map((f) => _FeatureRow(
                      icon: f['icon'] as IconData,
                      text: f['text'] as String,
                      color: service.color,
                    )),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookingScreen(service: service),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: service.color,
                          padding:
                          const EdgeInsets.symmetric(vertical: 18),
                        ),
                        icon: const Icon(Icons.calendar_today_rounded,
                            size: 20),
                        label: const Text(
                          'Book Now',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _features = [
    {
      'icon': Icons.verified_user_rounded,
      'text': 'Verified & background-checked professionals'
    },
    {'icon': Icons.timer_rounded, 'text': 'On-time service guarantee'},
    {
      'icon': Icons.replay_rounded,
      'text': 'Free re-service if not satisfied'
    },
    {
      'icon': Icons.support_agent_rounded,
      'text': '24/7 customer support'
    },
  ];
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _FeatureRow(
      {required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
