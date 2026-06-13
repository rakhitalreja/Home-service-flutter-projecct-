import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'add_booking_screen.dart';
import 'edit_booking_screen.dart';

class BookingsApiScreen extends StatefulWidget {
  const BookingsApiScreen({super.key});

  @override
  State<BookingsApiScreen> createState() => _BookingsApiScreenState();
}

class _BookingsApiScreenState extends State<BookingsApiScreen> {
  List bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    setState(() => isLoading = true);
    try {
      final data = await ApiService.getBookings();
      setState(() {
        bookings = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> deleteBooking(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await ApiService.deleteBooking(id);
      loadBookings();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking deleted!'), backgroundColor: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddBookingScreen()));
          loadBookings();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
          ? const Center(child: Text('No bookings found'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: bookings.length,
        itemBuilder: (ctx, i) {
          final b = bookings[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.calendar_today, color: Colors.white),
              ),
              title: Text(b['customer_name'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Date: ${b['booking_date']?.toString().substring(0, 10)}\nTime: ${b['booking_time']}\nStatus: ${b['status']}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditBookingScreen(booking: b)),
                      );
                      loadBookings();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteBooking(b['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}