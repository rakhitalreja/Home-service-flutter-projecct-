import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../models/booking_model.dart';
import '../widgets/app_scaffold.dart';

class BookingsScreen extends StatelessWidget {
  /// [standalone] = true  → wrapped in AppScaffold with bottom nav
  /// [standalone] = false → embedded inside HomeScreen's body (no extra Scaffold)
  final bool standalone;
  const BookingsScreen({super.key, this.standalone = true});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final bookings = appState.bookings;

    final content = Scaffold(
      backgroundColor: AppTheme.background,
      appBar: standalone
          ? AppBar(
        title: const Text('My Bookings'),
        automaticallyImplyLeading: false,
        actions: [
          if (bookings.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${bookings.length} booking${bookings.length > 1 ? 's' : ''}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
        ],
      )
          : AppBar(
        title: const Text('My Bookings'),
        automaticallyImplyLeading: false,
        actions: [
          if (bookings.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${bookings.length} booking${bookings.length > 1 ? 's' : ''}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: bookings.isEmpty
          ? _EmptyBookings()
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (ctx, i) {
          final booking = bookings[bookings.length - 1 - i];
          return _BookingCard(booking: booking);
        },
      ),
    );

    if (!standalone) return content;

    return AppScaffold(
      currentIndex: 1,
      showDrawer: false,
      body: content,
    );
  }
}

class _EmptyBookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFFDCEAFD),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              size: 56,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Bookings Yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Book a home service and it\nwill appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppTheme.textMedium,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingModel booking;
  const _BookingCard({required this.booking});

  Color get _statusColor {
    switch (booking.status) {
      case BookingStatus.pending:
        return AppTheme.warning;
      case BookingStatus.confirmed:
        return AppTheme.primary;
      case BookingStatus.completed:
        return AppTheme.success;
      case BookingStatus.cancelled:
        return Colors.red;
    }
  }

  IconData get _statusIcon {
    switch (booking.status) {
      case BookingStatus.pending:
        return Icons.hourglass_top_rounded;
      case BookingStatus.confirmed:
        return Icons.check_circle_outline_rounded;
      case BookingStatus.completed:
        return Icons.task_alt_rounded;
      case BookingStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: _statusColor.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(_statusIcon, color: _statusColor, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    booking.statusLabel,
                    style: TextStyle(
                      color: _statusColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'ID: ${booking.id.substring(2, 10)}',
                    style: const TextStyle(
                      color: AppTheme.textLight,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.home_repair_service_rounded,
                            color: AppTheme.primary, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.serviceName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              booking.priceLabel,
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  _infoRow(
                    Icons.calendar_today_rounded,
                    DateFormat('EEE, MMM d, yyyy').format(booking.date),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(Icons.access_time_rounded, booking.time),
                  const SizedBox(height: 8),
                  _infoRow(Icons.location_on_rounded, booking.address,
                      maxLines: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: maxLines > 1
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: AppTheme.textMedium),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
