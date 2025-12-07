import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For time formatting
import 'package:jklu_eezy/apicall/manage_menu.dart';
import 'package:jklu_eezy/components/admin_components/manage_menu.dart';
import 'package:jklu_eezy/components/user_components/mess/user_mess_menu.dart';
import 'dart:async';
import '../components/header/header.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';
late final String baseUrl = dotenv.env['BACKEND_URL']!;

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}









class MessManagementPage extends StatefulWidget {
  final bool isAdmin;
  const MessManagementPage({super.key, required this.isAdmin});

  @override
  State<MessManagementPage> createState() => _MessManagementPageState();
}

class _MessManagementPageState extends State<MessManagementPage> {

  Map<String, dynamic>? todayMenu;
  bool menuLoading = true;
  String selectedMeal = "Breakfast";



  Future<void> loadMenu() async {
  todayMenu = await fetchTodayMenu();
  setState(() => menuLoading = false);
}

  void downloadMenuFile(String format) {
    // TODO: Implement download functionality for PDF or PNG
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading menu as $format...')),
    );
  }



  bool isAdmin = false;
  bool visible = true;
  // Meal time ranges (24-hour format)
  final Map<String, List<String>> mealTimings = {
    "Breakfast": ["07:30", "09:30"],
    "Lunch": ["12:30", "14:30"],
    "Snacks": ["16:00", "18:00"],
    "Dinner": ["19:30", "21:30"],
  };

  String getMealStatus(String meal) {
    final now = DateTime.now();
    final format = DateFormat("HH:mm");

    final startTime = format.parse(mealTimings[meal]![0]);
    final endTime = format.parse(mealTimings[meal]![1]);

    // Convert to DateTime for comparison
    final start = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
    final end = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    if (now.isAfter(start) && now.isBefore(end)) {
      return "Open";
    } else if (now.isBefore(start)) {
      return "Upcoming";
    } else {
      return "Closed";
    }
  }




  @override
  void initState() {
    super.initState();
    isAdmin = widget.isAdmin;

    loadMenu(); // 🔥 Load today’s menu

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() => visible = !visible);
    });
  }


  // @override
  // void initState() {
  //   super.initState();
  //   isAdmin = widget.isAdmin;
  //   Timer.periodic(const Duration(milliseconds: 500), (timer) {
  //     setState(() => visible = !visible);
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      if (isAdmin) const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ManageWeeklyMenu()),
                        ).then((_) {
                          // 🔁 Refresh contact list when returning
                          // fetchContacts();
                        });
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Manage Menu',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 59, 105),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                    ]
                  ),
                  Row(
                    children: [
                  if (widget.isAdmin) // 👈 show button only for admin
                      BackButton(color: const Color.fromARGB(255, 3, 59, 105)),
                      SizedBox(width: 15),
                      const Text(
                        "Mess Management",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Today's menu, timings, and meal tickets",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Meal Ticket Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.qr_code_2, color: Colors.indigo),
                              SizedBox(width: 8),
                              const Text(
                                "Meal Ticket",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),

                              AnimatedOpacity(opacity: visible ? 1: 0, duration: const Duration(milliseconds: 300),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: const Text(
                                  'Coming Soon',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Colors.orangeAccent,
                              //       borderRadius: BorderRadius.circular(4),
                              //     ),
                              //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              //     child: const Text(
                              //       'Coming Soon',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.white,
                              //         fontSize: 13,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            onPressed: () {},
                            icon: Icon(Icons.qr_code,color: Colors.white,),
                            label: const Text(
                              "Generate QR Ticket",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                                ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Show this QR code at the mess entrance",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Timings Card (Dynamic Status)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.access_time, color: Colors.indigo),
                              SizedBox(width: 8),
                              Text(
                                "Timings",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          buildTimingRow("Breakfast", "7:30 AM - 9:30 AM", getMealStatus("Breakfast")),
                          buildTimingRow("Lunch", "12:30 PM - 2:30 PM", getMealStatus("Lunch")),
                          buildTimingRow("Snacks", "4:00 PM - 6:00 PM", getMealStatus("Snacks")),
                          buildTimingRow("Dinner", "7:30 PM - 9:30 PM", getMealStatus("Dinner")),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Today's Menu Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.calendar_today_outlined, color: Colors.indigo),
                              SizedBox(width: 8),
                              Text(
                                "Today's Menu",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey[200],
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       // Expanded(child: mealTab("Breakfast", false)),
                          //       // Expanded(child: mealTab("Lunch", true)),
                          //       // Expanded(child: mealTab("Dinner", false)),
                          //     ],
                          //   ),
                          // ),





                          Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedMeal = "Breakfast"),
                              child: mealTab("Breakfast", selectedMeal == "Breakfast"),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedMeal = "Lunch"),
                              child: mealTab("Lunch", selectedMeal == "Lunch"),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedMeal = "Snacks"),
                              child: mealTab("Snacks", selectedMeal == "Snacks"),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedMeal = "Dinner"),
                              child: mealTab("Dinner", selectedMeal == "Dinner"),
                            ),
                          ),
                        ],
                      ),
                    ),

                          const SizedBox(height: 16),

                          if (menuLoading)
                            const Center(child: CircularProgressIndicator())
                          else if (todayMenu == null)
                            const Text("No menu uploaded for today.")
                          else
                            buildMenuItem(
                              todayMenu!["days"][DateFormat("EEEE").format(DateTime.now())]
                                [selectedMeal.toLowerCase()],
                            ),










// ----------------- WEEKLY MENU PREVIEW ------------------
const SizedBox(height: 20),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImageViewer(
          imageUrl: "$baseUrl/uploads/menu.png?v=${DateTime.now().millisecondsSinceEpoch}",
        ),
      ),
    );
  },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Image.network(
      "$baseUrl/uploads/menu.png?v=${DateTime.now().millisecondsSinceEpoch}",
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Text("Menu preview not available"),
    ),
  ),
),




// GestureDetector(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => FullScreenImageViewer(
//         imageUrl: "$baseUrl/uploads/menu.png",
//         ),
//       ),
//     );
//   },
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(15),
//     // child: Image.network(
//     //   "sandbox:/mnt/data/43283ce2-2992-42b9-8540-ff77ddd5b5c9.png",
//     //   height: 250,
//     //   width: double.infinity,
//     //   fit: BoxFit.cover,
//     // ),

//     child: Image.network(
//   "$baseUrl/uploads/menu.png",
//   height: 250,
//   width: double.infinity,
//   fit: BoxFit.cover,
//   errorBuilder: (context, error, stackTrace) =>
//       const Text("Menu preview not available"),
// ),

//   ),
// ),

const SizedBox(height: 8),
Center(
  child: Text(
    "Tap to view weekly menu",
    style: TextStyle(color: Colors.black54, fontSize: 13),
  ),
),
const SizedBox(height: 20),
// ---------------------------------------------------------








                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    downloadMenuFile("pdf");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text("Download PDF", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    downloadMenuFile("png");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text("Download PNG", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
          ],
        ),
      ),
    ),
  ],
),
            ),
          ),
        ],
      ),
    );
  }

  // Widget mealTab(String title, bool selected) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: selected ? Colors.white : Colors.transparent,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Text(
  //       title,
  //       style: TextStyle(
  //         color: selected ? Colors.indigo : Colors.black54,
  //         fontWeight: selected ? FontWeight.bold : FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }

// Widget buildTimingRow(String meal, String time, String status) {
//   Color bgColor;
//   Color textColor;

//   switch (status) {
//     case "Open":
//       bgColor = Colors.green[100]!;
//       textColor = Colors.green;
//       break;
//     case "Upcoming":
//       bgColor = const Color.fromARGB(255, 243, 225, 217);
//       textColor = Colors.black;
//       break;
//     default:
//       bgColor = Colors.red[100]!;
//       textColor = Colors.red;
//   }

//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: Row(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(6),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           child: Text(
//             meal,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Text(
//           time,
//           style: const TextStyle(
//             color: Colors.black87,
//             fontSize: 14,
//           ),
//         ),
//         const Spacer(),
//         Container(
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(6),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           child: Text(
//             status,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }








Widget buildTimingRow(String meal, String time, String status) {
  Color statusColor;

  switch (status) {
    case "Open":
      statusColor = Colors.green;
      break;
    case "Upcoming":
      statusColor = Colors.orange;
      break;
    default:
      statusColor = Colors.red;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Meal block (Breakfast, Lunch, etc.)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meal,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        const Spacer(),

        // Status block (Open, Closed, Upcoming)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}






}
