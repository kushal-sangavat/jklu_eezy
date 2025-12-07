import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../storage.dart'; // import where getContactsByRole() is defined
import '../quick_action/EmergencyCard.dart';
Widget buildRoleCard(
  String position,
  String subtitle,
  IconData icon,
  Color color,
) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: getContactsByPosition(position),
    builder: (context, snapshot) {
      // 🕒 Loading state
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      // ❌ No contact found
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return buildEmergencyCard(
          icon: icon,
          iconColor: Colors.white,
          iconBgColor: Colors.grey,
          title: position,
          subtitle: subtitle,
          personName: "Not Available",
          callText: "No contact found",
          buttonColor: Colors.grey,
          onCall: () {},
        );
      }

      // ✅ Contact found
      final contact = snapshot.data!.first;

      return buildEmergencyCard(
        icon: icon,
        iconColor: Colors.white,
        iconBgColor: color,
        title: contact['position'] ?? position,
        subtitle: subtitle,
        personName: contact['name'] ?? "Unknown",
        callText: "Call ${contact['phone'] ?? 'N/A'}",
        buttonColor: color,
        onCall: () {
          final phone = contact['phone'];
          if (phone != null && phone.isNotEmpty) {
            launchUrl(Uri.parse("tel:$phone"));
          }
        },
      );
    },
  );
}




//----------------------warden ----------------------


/// Dynamically builds a Contact Card for a given warden role
Widget buildWardenCard({
  required String position,           // Example: "BH1 Boys Warden"
  required String location,       // Example: "Block A"
  required String availability,   // Example: "24/7 Available"
}) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: getContactsByPosition(position),
    builder: (context, snapshot) {
      // 🕒 Loading state
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      // ❌ No contact found
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(Icons.person, size: 40, color: Colors.grey),
              title: Text("Not Available"),
              subtitle: Text("No contact found for this warden."),
            ),
          ),
        );
      }

      // ✅ Contact found (show the first one)
      final contact = snapshot.data!.first;

      final name = contact['name'] ?? "Unknown";
      final post = contact['position'] ?? position;
      final phone = contact['phone'] ?? "";

      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.person, size: 40, color: Colors.green),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(post, style: const TextStyle(color: Colors.black54)),
                    Text(location, style: const TextStyle(color: Colors.black54)),
                    Text(
                      availability,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (phone.isNotEmpty) {
                    final Uri dialUri = Uri.parse('tel:$phone');
                    if (!await launchUrl(dialUri)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not open dialer')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(249, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Call"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
