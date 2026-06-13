
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/service_model.dart';
import '../widgets/service_card.dart';
import '../widgets/app_scaffold.dart';
import 'service_detail_screen.dart';
import 'bookings_screen.dart';
import 'profile_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_currentIndex) {
      case 1:
        body = const BookingsScreen(standalone: false);
        break;
      case 2:
        body = const ProfileScreen(standalone: false);
        break;
      default:
        body = _HomeTab(
          searchCtrl: _searchCtrl,
          searchQuery: _searchQuery,
          onSearchChanged: (v) => setState(() => _searchQuery = v),
        );
    }

    return AppScaffold(
      currentIndex: _currentIndex,
      showDrawer: _currentIndex == 0,
      appBar: _currentIndex == 0 ? _buildHomeAppBar(context) : null,
      body: body,
    );
  }

  AppBar _buildHomeAppBar(BuildContext context) {
    // The home tab uses a SliverAppBar inside, so we return a transparent
    // AppBar that just shows the drawer hamburger menu.
    return AppBar(
      backgroundColor: AppTheme.primary,
      elevation: 0,
      automaticallyImplyLeading: true, // shows drawer icon automatically
      title: const Text('HomeServe'),
    );
  }
}

// ─── Home Tab ────────────────────────────────────────────────────────────────

class _HomeTab extends StatelessWidget {
  final TextEditingController searchCtrl;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const _HomeTab({
    required this.searchCtrl,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final userName = appState.currentUser?.name ?? 'Customer';

    final filtered = dummyServices
        .where((s) =>
        s.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            floating: false,
            pinned: false,
            automaticallyImplyLeading: false,
            backgroundColor: AppTheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primary, AppTheme.primaryDark],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${userName.split(' ').first} 👋',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'What service do you need?',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: Text(
                            userName.isNotEmpty
                                ? userName[0].toUpperCase()
                                : 'C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: searchCtrl,
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: AppTheme.textMedium),
                    suffixIcon: searchCtrl.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear_rounded,
                          color: AppTheme.textMedium),
                      onPressed: () {
                        searchCtrl.clear();
                        onSearchChanged('');
                      },
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Promo banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: _PromoBanner(),
            ),
          ),

          // Section title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Row(
                children: [
                  const Text(
                    'Our Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${filtered.length} available',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Service grid
          filtered.isEmpty
              ? const SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off_rounded,
                      size: 60, color: AppTheme.textLight),
                  SizedBox(height: 12),
                  Text(
                    'No services found',
                    style: TextStyle(
                        color: AppTheme.textMedium, fontSize: 16),
                  ),
                ],
              ),
            ),
          )
              : SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.95,
              ),
              delegate: SliverChildBuilderDelegate(
                    (ctx, i) => ServiceCard(
                  service: filtered[i],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ServiceDetailScreen(service: filtered[i]),
                    ),
                  ),
                ),
                childCount: filtered.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF9E00)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accent.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🎉 First Booking FREE!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Get 100% off on your first home service booking.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Claim',
              style: TextStyle(
                color: AppTheme.accent,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


