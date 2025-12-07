import 'package:flutter/material.dart';


Widget buildContactCard({
    required String name,
    required String post,
    required String location,
    required String availability,
    required VoidCallback onCall,
  }) {
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
              onPressed: onCall,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(249, 255, 255, 255),
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
  }