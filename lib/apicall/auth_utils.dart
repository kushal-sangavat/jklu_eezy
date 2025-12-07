import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jklu_eezy/components/storage.dart';

/// Checks if the current user is an admin by decoding the JWT token.
Future<bool> checkAdminStatus() async {
  final token = await getToken();
  if (token == null) return false;

  try {
    final payload = json.decode(
      utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))),
    );

    print('Token payload: $payload'); // Debug print
    // Check if role exists in payload
    if (payload.containsKey('role')) {
      print('Role found in token: ${payload['role']}');
      return payload['role'] == 'admin';
    }
    
    // If no role in token, try to get it from the full response
    try {
      String baseUrl = Platform.isAndroid ? "${dotenv.env['PROD_BACKEND_URL']}" : "${dotenv.env['BACKEND_URL']}";
      print('Base URL: $baseUrl'); // Debug
      final response = await http.get(
        Uri.parse('$baseUrl/api/auth/me'),
        headers: {
          'Authorization': 'Bearer ${await getToken()}',
        },
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        return userData['role'] == 'admin';
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
    
    return false;
  } catch (e) {
    print('Error decoding token: $e');
    return false;
  }
}
