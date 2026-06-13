import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class EditBookingScreen extends StatefulWidget {
  final Map booking;
  const EditBookingScreen({super.key, required this.booking});

  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _dateCtrl;
  late TextEditingController _timeCtrl;
  late String _status;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.booking['customer_name']);
    _addressCtrl = TextEditingController(text: widget.booking['address']);
    _dateCtrl = TextEditingController(
        text: widget.booking['booking_date']?.toString().substring(0, 10));
    _timeCtrl = TextEditingController(text: widget.booking['booking_time']);
    _status = widget.booking['status'] ?? 'pending';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await ApiService.updateBooking(widget.booking['id'], {
      'service_id': widget.booking['service_id'],
      'customer_name': _nameCtrl.text,
      'address': _addressCtrl.text,
      'booking_date': _dateCtrl.text,
      'booking_time': _timeCtrl.text,
      'status': _status,
    });
    setState(() => _isLoading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Booking updated!'),
          backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Booking'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder()),
                maxLines: 2,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateCtrl,
                decoration: const InputDecoration(
                    labelText: 'Date (YYYY-MM-DD)',
                    border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeCtrl,
                decoration: const InputDecoration(
                    labelText: 'Time (e.g. 10:00 AM)',
                    border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder()),
                items: ['pending', 'confirmed', 'completed', 'cancelled']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _status = v!),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Update Booking',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}