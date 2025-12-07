import 'package:flutter/material.dart';

// Widget buildMenuItem(String dish, String desc,) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 10),
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       color: Colors.grey[100],
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 dish,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//               Text(
//                 desc,
//                 style: const TextStyle(
//                   color: Colors.black54,
//                   fontSize: 13,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }





// Widget buildMenuItem(String desc) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 10),
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       color: Colors.grey[100],
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Text(
//       desc.replaceAll(",", ",\n"),  // 🔥 NEW: each item on a new line
//       style: const TextStyle(
//         color: Colors.black87,
//         fontSize: 15,
//         height: 1.4,
//       ),
//     ),
//   );
// }



Widget buildMenuItem(String desc) {
  // Split comma-separated items
  List<String> items = desc.split(',').map((e) => e.trim()).toList();

  return Column(
    children: items.map((item) {
      return Container(
        width: double.infinity, // 🔥 FULL WIDTH
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList(),
  );
}



Widget mealTab(String title, bool selected) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: selected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: selected ? Colors.indigo : Colors.black54,
        fontWeight: selected ? FontWeight.bold : FontWeight.w500,
      ),
    ),
  );
}
