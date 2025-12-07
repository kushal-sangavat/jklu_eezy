import 'package:flutter/material.dart';

class BlockLostnfound extends StatelessWidget {
    final String title;
  final String description;
  final String location;
  final String dateFound;
  final String? imageUrl;
  const BlockLostnfound({super.key,
    required this.title,
    required this.description,
    required this.location,
    required this.dateFound,
    this.imageUrl,});

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_outlined,
                        size: 50, color: Colors.grey),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 18, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(location,
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text("Found on $dateFound",
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(height: 1),

                const SizedBox(height: 12),



                // 👤 Contact Info
                // Row(
                //   children: [
                //     // Circular initials avatar
                //     CircleAvatar(
                //       radius: 20,
                //       backgroundColor: Colors.grey[300],
                //       child: Text(
                //         contactName.isNotEmpty
                //             ? contactName.substring(0, 2).toUpperCase()
                //             : '',
                //         style: const TextStyle(
                //             color: Colors.black87,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     const SizedBox(width: 10),

                //     // Contact details
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "$contactRole - $contactName",
                //             style: const TextStyle(
                //                 fontWeight: FontWeight.w600, fontSize: 14),
                //           ),
                //           Row(
                //             children: [
                //               const Icon(Icons.phone,
                //                   size: 14, color: Colors.grey),
                //               const SizedBox(width: 4),
                //               Text(
                //                 phoneNumber,
                //                 style: const TextStyle(color: Colors.grey),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),





                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle contact action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B2040),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.phone, color: Colors.white),
                    label: const Text(
                      'Contact to Claim',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
}
}