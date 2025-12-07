
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../components/storage.dart';

class UserService {
  // Singleton
  UserService._privateConstructor();
  static final UserService instance = UserService._privateConstructor();

  String username = "";
  String email = "";
  String role = "";

  // Call this once at app start
  Future<void> loadUser() async {
    try {
      String baseUrl = Platform.isAndroid ? "${dotenv.env['PROD_BACKEND_URL']}" : "${dotenv.env['BACKEND_URL']}";

      final response = await http.get(
        Uri.parse('$baseUrl/api/user/details'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getToken()}',
        },
      );

      print('Full API response: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        username = data['name'] ?? '';
        email = data['email'] ?? '';
        role = (data['role'] as String?)?.trim().toLowerCase() ?? '';

        print('Loaded user role: $role');
      } else {
        print("Failed to fetch user details: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }


  }
}
