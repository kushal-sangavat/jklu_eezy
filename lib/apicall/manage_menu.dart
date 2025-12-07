// Future<Map<String, dynamic>?> fetchTodayMenu() async {
//   final baseUrl = dotenv.env['BACKEND_URL'];
//   final url = Uri.parse("$baseUrl/api/menu/all");

//   try {
//     final token = await getToken();
//     final response = await http.get(
//       url,
//       headers: {"Authorization": "Bearer $token"},
//     );

//     if (response.statusCode != 200) {
//       print("Failed to fetch: ${response.body}");
//       return null;
//     }

//     List menus = jsonDecode(response.body);

//     if (menus.isEmpty) return null;

//     DateTime today = DateTime.now();

//     // find menu valid for today's date
//     for (var menu in menus) {
//       DateTime from = DateTime.parse(menu["fromDate"]);
//       DateTime to = DateTime.parse(menu["toDate"]);

//       if (today.isAfter(from) && today.isBefore(to.add(const Duration(days: 1)))) {
//         return menu; // ← return today’s active weekly menu
//       }
//     }

//     return null;
//   } catch (e) {
//     print("Error: $e");
//     return null;
//   }
// }
























import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jklu_eezy/components/storage.dart';

Future<Map<String, dynamic>?> fetchTodayMenu() async {
  final baseUrl = dotenv.env['BACKEND_URL'];
  final url = Uri.parse("$baseUrl/api/menu/all");

  try {
    final token = await getToken();
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      print("Failed to fetch: ${response.body}");
      return null;
    }

    List menus = jsonDecode(response.body);

    if (menus.isEmpty) return null;

    // Get today's date (clear time part)
    DateTime today = DateTime.now();
    DateTime todayDate = DateTime(today.year, today.month, today.day);

    for (var menu in menus) {
      DateTime from = DateTime.parse(menu["fromDate"]);
      DateTime to = DateTime.parse(menu["toDate"]);

      DateTime fromDate = DateTime(from.year, from.month, from.day);
      DateTime toDate   = DateTime(to.year, to.month, to.day);

      // Check if today lies between the date range (inclusive)
      if (todayDate.isAtSameMomentAs(fromDate) ||
          todayDate.isAtSameMomentAs(toDate) ||
          (todayDate.isAfter(fromDate) && todayDate.isBefore(toDate))) {
        return menu;
      }
    }

    return null;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
