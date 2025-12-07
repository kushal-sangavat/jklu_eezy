import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jklu_eezy/components/storage.dart';

Future<List<dynamic>> fetchLostFoundItems() async {
  final baseUrl = dotenv.env['BACKEND_URL'];
  final url = Uri.parse("$baseUrl/api/lostfound/all");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(jsonDecode(response.body));
  } else {
    return [];
  }
}

Future<bool> uploadLostFoundItem({
  required String title,
  required String description,
  required String location,
  required String dateFound,
  required File imageFile,
}) async {
  final baseUrl = dotenv.env['BACKEND_URL'];
  final url = Uri.parse("$baseUrl/api/lostfound/add");

  final token = await getToken(); // 🔥 token from local storage

  var request = http.MultipartRequest("POST", url);

  request.headers['Authorization'] = "Bearer $token";

  request.fields['title'] = title;
  request.fields['description'] = description;
  request.fields['location'] = location;
  request.fields['dateFound'] = dateFound;

  request.files.add(
    await http.MultipartFile.fromPath("image", imageFile.path),
  );

  final response = await request.send();

  return response.statusCode == 201;
}
