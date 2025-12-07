import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:jklu_eezy/apicall/auth_utils.dart';
import 'package:jklu_eezy/components/storage.dart';

const String BASE_URL = "http://localhost:3000/api/laundry";


// --------------------------------------------------
// Fetch Laundry — Admin = all, User = only their own
// --------------------------------------------------
Future<List<dynamic>> fetchAllLaundry() async {
  final token = await getToken();

  final response = await http.get(
    Uri.parse(BASE_URL),
    headers: {"Authorization": "Bearer $token"},
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  return [];
}

Future<List<dynamic>> fetchMyLaundry() async {
  final token = await getToken();

  final response = await http.get(
    Uri.parse("$BASE_URL/me"),
    headers: {"Authorization": "Bearer $token"},
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  return [];
}


// --------------------------------------------------
// Admin → Create a Laundry Request
// --------------------------------------------------
Future<bool> createLaundryRequest({
  required String cardNumber,
  required double weight,
}) async {
  final token = await getToken();

  final response = await http.post(
    Uri.parse(BASE_URL),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
    body: jsonEncode({
      "cardNumber": cardNumber,
      "weight": weight,
    }),
  );

  return response.statusCode == 201;
}


// --------------------------------------------------
// User → Accept Laundry Request
// --------------------------------------------------
Future<bool> acceptLaundry(String id) async {
  final token = await getToken();

  final response = await http.put(
    Uri.parse("$BASE_URL/accept/$id"),
    headers: {"Authorization": "Bearer $token"},
  );

  return response.statusCode == 200;
}


// --------------------------------------------------
// Admin → Mark Laundry as Done (clothes washed)
// --------------------------------------------------
Future<bool> markLaundryDone(String id) async {
  final token = await getToken();

  final response = await http.put(
    Uri.parse("$BASE_URL/done/$id"),
    headers: {"Authorization": "Bearer $token"},
  );

  return response.statusCode == 200;
}


// --------------------------------------------------
// User → Mark as Picked Up (close request)
// --------------------------------------------------
Future<bool> completeLaundryByUser(String id) async {
  final token = await getToken();

  final response = await http.put(
    Uri.parse("$BASE_URL/complete/$id"),
    headers: {"Authorization": "Bearer $token"},
  );

  return response.statusCode == 200;
}
