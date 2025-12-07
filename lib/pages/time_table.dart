

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jklu_eezy/apicall/auth_utils.dart';
import 'package:jklu_eezy/components/admin_components/upload_timetable_page.dart';
import 'package:jklu_eezy/components/header/header.dart';
// import 'package:jklu_eezy/components/storage.dart';

// 🌐 Backend URL
const String BACKEND_URL = "http://localhost:3000";

class TimeTable1 extends StatefulWidget {
  final bool isAdmin;
  const TimeTable1({super.key, this.isAdmin = false});

  @override
  State<TimeTable1> createState() => _TimeTable1State();
}



//------------------- Zoom View Widget ------------------//

class TimeTableZoomViewAsset extends StatelessWidget {
  final String imagePath;

  const TimeTableZoomViewAsset({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withOpacity(0.7)),
          ),

          Center(
            child: Hero(
              tag: "timetable",
              child: InteractiveViewer(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 26, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//------------------- End Zoom View Widget ------------------//


class _TimeTable1State extends State<TimeTable1> {



//------------------- Static Timetable Widget ------------------//
  Widget showStaticTimetable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Timetable",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(9, 31, 94, 1.0),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) =>
                      TimeTableZoomViewAsset(
                        imagePath: "assets/images/timetable.jpeg",
                      ),
                ),
              );
            },
            child: Hero(
              tag: "timetable",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/timetable.jpeg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//------------------- End Static Timetable Widget ------------------//




  int? selectedCourse;
  String? selectedYear;
  bool isAdmin = false;
  List<dynamic> timetableData = [];

  final List<Map<String, String>> courses = [
    {'name': 'B.Tech', 'duration': '4 Years'},
    {'name': 'BBA', 'duration': '3 Years'},
    {'name': 'MBA', 'duration': '2 Years'},
    {'name': 'B.Des', 'duration': '4 Years'},
  ];

  final List<List<String>> years = [
    ["1st Year", "2nd Year", "3rd Year", "4th Year"],
    ["1st Year", "2nd Year", "3rd Year"],
    ["1st Year", "2nd Year"],
    ["1st Year", "2nd Year", "3rd Year", "4th Year"],
  ];
  

  @override
  void initState() {
    super.initState();
    initSetup();
  }

  Future<void> initSetup() async {
    try {
      bool adminStatus = await checkAdminStatus();
      setState(() => isAdmin = adminStatus);
      await fetchTimetables();
    } catch (e) {
      print("Error in initSetup: $e");
    }
  }

  Future<void> fetchTimetables() async {
    try {
      final response = await http.get(Uri.parse("$BACKEND_URL/api/timetable"));
      if (response.statusCode == 200) {
        setState(() {
          timetableData = jsonDecode(response.body);
        });
        print("Fetched ${timetableData.length} timetables from backend");
      } else {
        print("Failed to load timetables: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching timetables: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            // ✅ Header Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Color.fromRGBO(9, 31, 94, 1.0)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Back to Dashboard",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(9, 31, 94, 1.0),
                    ),
                  ),
                  const Spacer(),
                  if (isAdmin)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UploadTimetablePage()),
                        ).then((_) => fetchTimetables());
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text("Edit",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ✅ Main Scrollable Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Select Your Stream',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(9, 31, 94, 1.0),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Grid of courses
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCourse = index;
                            selectedYear = null;
                          });
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: selectedCourse == index
                                  ? const Color.fromRGBO(9, 31, 94, 1.0)
                                  : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  color: Colors.indigo, size: 40),
                              const SizedBox(height: 16),
                              Text(
                                course['name']!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(9, 31, 94, 1.0),
                                ),
                              ),
                              Text(course['duration']!,
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Select Your Year',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(9, 31, 94, 1.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF1A237E), width: 2),
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text("Select Year"),
                        value: selectedYear,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey),
                        items: selectedCourse == null
                            ? []
                            : years[selectedCourse!].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(9, 31, 94, 1.0),
                                    ),
                                  ),
                                );
                              }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  if (selectedCourse != null && selectedYear != null)
                    // buildTimetableImage(context),
                    showStaticTimetable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildTimetableImage(BuildContext context) {
  //   // final selected = timetableData.firstWhere(
  //   //   (item) =>
  //   //       item['course'] == courses[selectedCourse!]['name'] &&
  //   //       item['year'] == selectedYear,
  //   //   orElse: () => null,
  //   // );

  //   // if (selected == null) {
  //   //   return const Center(
  //   //     child: Padding(
  //   //       padding: EdgeInsets.all(16),
  //   //       child: Text("No timetable found for this selection.",
  //   //           style: TextStyle(color: Colors.grey, fontSize: 16)),
  //   //     ),
  //   //   );
  //   // }

  //   // final imageUrl = "$BACKEND_URL${selected['imageUrl']}";
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         "Your Timetable",
  //         style: TextStyle(
  //           fontSize: 22,
  //           fontWeight: FontWeight.bold,
  //           color: Color.fromRGBO(9, 31, 94, 1.0),
  //         ),
  //       ),
  //       const SizedBox(height: 12),
  //       Center(
  //         child: GestureDetector(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               PageRouteBuilder(
  //                 opaque: false,
  //                 pageBuilder: (_, __, ___) =>
  //                     TimeTableZoomView(imagePath: imageUrl),
  //               ),
  //             );
  //           },
  //           child: Hero(
  //             tag: imageUrl,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(12),
  //               child: Image.network(imageUrl,
  //                   fit: BoxFit.contain, errorBuilder: (context, _, __) {
  //                 return const Icon(Icons.broken_image, size: 100);
  //               }),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class TimeTableZoomView extends StatelessWidget {
  final String imagePath;
  const TimeTableZoomView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withOpacity(0.7)),
          ),
          Center(
            child: Hero(
              tag: imagePath,
              child: InteractiveViewer(
                child: Image.network(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.close, color: Colors.black, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
