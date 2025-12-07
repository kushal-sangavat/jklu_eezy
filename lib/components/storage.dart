import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

final storage = const FlutterSecureStorage();

// Save token only
Future<void> saveToken(String token) async {
  await storage.write(key: "token", value: token);
}

// Read token
Future<String?> getToken() async {
  return await storage.read(key: "token");
}

// Delete token (logout)
Future<void> logout() async {
  await storage.delete(key: "token");
    await storage.delete(key: "card_number");
}

// -------------------------- Saved contacts helpers -----------------------
// Stores a JSON-encoded list of contacts for fast access across pages.

Future<void> saveContactsByRole(List<Map<String, dynamic>> contacts) async {
  try {
    // ✅ Important positions (these match your backend data)
    const importantPositions = [
      'Head Guard',
      'BH1 Boys Warden',
      'BH2 Boys Warden',
      'GH1 Girls Warden',
      'GH2 Girls Warden',
    ];

    // ✅ Filter by position instead of role
    final filteredContacts = contacts
        .where((c) => importantPositions.contains(c['position']))
        .map((c) => {
              'id': c['_id'] ?? c['id'] ?? '',
              'name': c['name'] ?? '',
              'position': c['position'] ?? '',
              'phone': c['phone'] ?? '',
              'role': c['role'] ?? '',
              'department': c['department'] ?? '',
              'location': c['location'] ?? '',
            })
        .toList();

    await storage.write(
      key: 'important_contacts',
      value: json.encode(filteredContacts),
    );

    print('✅ Saved ${filteredContacts.length} important contacts by position.');
  } catch (e) {
    print('❌ Error saving contacts by position: $e');
  }
}


Future<List<Map<String, dynamic>>> getContactsByPosition(String position) async {
  final jsonStr = await storage.read(key: 'important_contacts');
  if (jsonStr == null) return [];

  final allContacts = List<Map<String, dynamic>>.from(json.decode(jsonStr));

  // Match on position instead of role
  final filtered = allContacts
      .where((c) =>
          (c['position'] ?? '').toString().toLowerCase() ==
          position.toLowerCase())
      .toList();

  return filtered;
}





Future<void> saveCardNumber(String cardNumber) async {
  await storage.write(key: "card_number", value: cardNumber);
}
Future<String?> getCardNumber() async {
  return await storage.read(key: "card_number");
}
Future<void> deleteCardNumber() async {
  await storage.delete(key: "card_number");
}