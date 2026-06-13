import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:3000/api';

class ApiService {
  static Future<List> getServices() async {
    final res = await http.get(Uri.parse('$baseUrl/services'));
    return jsonDecode(res.body);
  }
  static Future<bool> createService(Map data) async {
    final res = await http.post(Uri.parse('$baseUrl/services'), headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
    return res.statusCode == 200;
  }
  static Future<bool> updateService(int id, Map data) async {
    final res = await http.put(Uri.parse('$baseUrl/services/$id'), headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
    return res.statusCode == 200;
  }
  static Future<bool> deleteService(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/services/$id'));
    return res.statusCode == 200;
  }
  static Future<List> getBookings() async {
    final res = await http.get(Uri.parse('$baseUrl/bookings'));
    return jsonDecode(res.body);
  }
  static Future<bool> createBooking(Map data) async {
    final res = await http.post(Uri.parse('$baseUrl/bookings'), headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
    return res.statusCode == 200;
  }
  static Future<bool> updateBooking(int id, Map data) async {
    final res = await http.put(Uri.parse('$baseUrl/bookings/$id'), headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
    return res.statusCode == 200;
  }
  static Future<bool> deleteBooking(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/bookings/$id'));
    return res.statusCode == 200;
  }
}
