enum BookingStatus { pending, confirmed, completed, cancelled }

class BookingModel {
  final String id;
  final String serviceName;
  final DateTime date;
  final String time;
  final String address;
  final BookingStatus status;
  final String priceLabel;

  const BookingModel({
    required this.id,
    required this.serviceName,
    required this.date,
    required this.time,
    required this.address,
    required this.priceLabel,
    this.status = BookingStatus.pending,
  });

  String get statusLabel {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }
}