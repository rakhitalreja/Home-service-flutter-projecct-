import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'add_service_screen.dart';
import 'edit_service_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List services = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  Future<void> loadServices() async {
    setState(() => isLoading = true);
    try {
      final data = await ApiService.getServices();
      setState(() {
        services = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> deleteService(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Service'),
        content: const Text('Are you sure you want to delete this service?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await ApiService.deleteService(id);
      loadServices();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service deleted!'), backgroundColor: Colors.green),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddServiceScreen()));
          loadServices();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : services.isEmpty
          ? const Center(child: Text('No services found'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: services.length,
        itemBuilder: (ctx, i) {
          final s = services[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.home_repair_service, color: Colors.white),
              ),
              title: Text(s['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Price: Rs. ${s['price']}\n${s['description']}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditServiceScreen(service: s)),
                      );
                      loadServices();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteService(s['id']),
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