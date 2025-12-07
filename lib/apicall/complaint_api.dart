import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jklu_eezy/components/storage.dart';

String baseUrl = dotenv.env['BACKEND_URL']!;

Future<bool> submitComplaint({
  required String category,
  required String title,
  required String description,
}) async {
  final token = await getToken();

  final response = await http.post(
    Uri.parse("$baseUrl/api/complaints/add"),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    },
    body: jsonEncode({
      "category": category,
      "title": title,
      "description": description,
    }),
  );

  return response.statusCode == 201;
}

Future<List> fetchMyComplaints() async {
  final token = await getToken();

  final res = await http.get(
    Uri.parse("$baseUrl/api/complaints/my"),
    headers: {"Authorization": "Bearer $token"},
  );

  return jsonDecode(res.body);
}

Future<List> fetchAllComplaints() async {
  final token = await getToken();

  final res = await http.get(
    Uri.parse("$baseUrl/api/complaints/all"),
    headers: {"Authorization": "Bearer $token"},
  );

  return jsonDecode(res.body);
}

Future<bool> resolveComplaint(String id) async {
  final token = await getToken();

  final res = await http.patch(
    Uri.parse("$baseUrl/api/complaints/resolve/$id"),
    headers: {"Authorization": "Bearer $token"},
  );

  return res.statusCode == 200;
}
