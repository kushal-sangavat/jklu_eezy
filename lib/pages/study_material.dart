import 'package:flutter/material.dart';
import 'package:jklu_eezy/components/header/header.dart';
//import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:url_launcher/url_launcher.dart';



Future<void> openMyCogPortal() async {
  final Uri url = Uri.parse("https://lrc.jklu.edu.in");

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}


class StudyMaterial extends StatefulWidget {final bool isAdmin;

const StudyMaterial({
  Key? key,
  this.isAdmin = false, // default false
}) : super(key: key);


  @override
  State<StudyMaterial> createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  bool get isAdmin => widget.isAdmin;
  int? selectedIndex; // null = nothing selected
  int resourcesIndex = 0;

  final List<String> Resources = ["Subjects", "Books", "Exam Papers"];

  final List<Map<String, dynamic>> streams = [
    {"title": "B.Tech", "icon": Icons.menu_book_rounded, "color": Colors.blue},
    {"title": "BBA", "icon": Icons.menu_book_rounded, "color": Colors.green},
    {"title": "MBA", "icon": Icons.menu_book_rounded, "color": Colors.purple},
    {"title": "B.Des", "icon": Icons.menu_book_rounded, "color": Colors.orange},
  ];

  // -------- ADDED: Dummy content for each course --------
  final Map<String, List<String>> streamSubject = {
    "B.Tech": [
      "Engineering Mathematics",
      "Data Structures",
      "Operating Systems",
      "Computer Networks",
    ],
    "BBA": [
      "Principles of Management",
      "Business Economics",
      "Marketing Basics",
    ],
    "MBA": [
      "Financial Management",
      "Business Analytics",
      "Human Resource Management",
    ],
    "B.Des": [
      "Design Thinking",
      "User Experience Design",
      "Product Design Basics",
    ],
  };

  final Map<String, List<String>> streamBooks = {
    "B.Tech": [
      "Engineering Mathematics",
      "Data Structures",
      "Operating Systems",
      "Computer Networks",
    ],
    "BBA": [
      "Principles of Management",
      "Business Economics",
      "Marketing Basics",
    ],
    "MBA": [
      "Financial Management",
      "Business Analytics",
      "Human Resource Management",
    ],
    "B.Des": [
      "Design Thinking",
      "User Experience Design",
      "Product Design Basics",
    ],
  };

  final Map<String, List<String>> streamExamPapers = {
    "B.Tech": [
      "Engineering Mathematics",
      "Data Structures",
      "Operating Systems",
      "Computer Networks",
    ],
    "BBA": [
      "Principles of Management",
      "Business Economics",
      "Marketing Basics",
    ],
    "MBA": [
      "Financial Management",
      "Business Analytics",
      "Human Resource Management",
    ],
    "B.Des": [
      "Design Thinking",
      "User Experience Design",
      "Product Design Basics",
    ],
  };

  // ------------------------------------------------------

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF6F7FB),
    body: SafeArea(
      child: Column(
        children: [
          // 🔹 Header with NO padding
          const Header(),
          const SizedBox(height: 10),

          // 🔹 Everything else gets 20 padding
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const BackButton(
                                color: Color.fromARGB(255, 3, 59, 105),
                              ),
                              Flexible(
                                child: Text(
                                  'Back to Dashboard',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 3, 59, 105),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              if (isAdmin)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const Announcement(),
                                      //   ),
                                      // ).then((_) => fetchAnnouncements());
                                    },
                                    icon: const Icon(Icons.add, color: Colors.white),
                                    label: const Text(
                                      'Add Announcement',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 3, 59, 105),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),



                  const SizedBox(height: 10),



                  const Text(
                    "Study Materials",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Access books, papers, and learning resources",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),

                  const SizedBox(height: 25),

                  // ----------------------------------
                  // Your Portal Card
                  // ----------------------------------

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFCFD8DC),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.open_in_new,
                                size: 27,
                                color: Color(0xFF0A3B8A),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "JKLU Lrc Portal",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Access your courses, assignments, grades, and digital resources "
                          "through the official JLKU Lrc portal.",
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 15),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A3B8A),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: openMyCogPortal,
                          icon: const Icon(
                            Icons.open_in_new_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Open jklu Lrc Portal",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ----------------------------------
                  // Browse by Stream
                  // ----------------------------------
                  const Text(
                    "Browse by Stream",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 15),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: streams.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.05,
                    ),
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex =
                                selectedIndex == index ? null : index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF0A3B8A)
                                  : const Color(0xFFBFC1C6),
                              width: isSelected ? 2 : 0.8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: streams[index]["color"]
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  streams[index]["icon"],
                                  size: 30,
                                  color: streams[index]["color"],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                streams[index]["title"],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "3 Departments",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

              const SizedBox(height: 20),






              if (selectedIndex != null) ...[
                const SizedBox(height: 10),

                Text(
                  "${streams[selectedIndex!]["title"]} Materials",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(5),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xAEE0ECF3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: Resources.length,
                    itemBuilder: (context, index) {
                      final resource = Resources[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            resourcesIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          padding: const EdgeInsets.all(12),
                          //margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: resourcesIndex == index
                                ? Colors.white
                                : null,
                          ),

                          child: Text(
                            resource,
                            style: TextStyle(
                              color: resourcesIndex == index
                                  ? Colors.black
                                  : Color(0xAE1D4153),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 15),

                if (resourcesIndex == 0) ...[
                  ...streamSubject[streams[selectedIndex!]["title"]]!.map(
                    (item) => Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFCBCED3), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            children: [
                              Text("Books"),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF33CD70),
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                    right: Radius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "6",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            children: [
                              Text("Papers"),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF33CD70),
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                    right: Radius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "15",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                if (resourcesIndex == 1) ...[
                  ...streamBooks[streams[selectedIndex!]["title"]]!.map(
                        (item) => Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFCBCED3), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),

                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: streams[selectedIndex!]["color"].withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.menu_book_rounded,
                                  color: streams[selectedIndex!]["color"],
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 7),

                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 5,
                                      children: const [
                                        Text("Computer Science"),
                                        Text("•"),
                                        Text("2nd Year"),
                                        Text("•"),
                                        Text("2.3 MB"),
                                      ],
                                    ),
                                    const SizedBox(height: 7),

                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 5,
                                      children: const [
                                        Icon(Icons.star, color: Colors.yellow, size: 20),
                                        Text("4.8"),
                                        Icon(Icons.download),
                                        Text("234 downloads")
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    // ⬇ DOWNLOAD BUTTON (MOVES DOWN ON SMALL SCREENS)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 3,
                                          backgroundColor: const Color(0xFFF6F7FB),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {

                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.download),
                                            SizedBox(width: 8),
                                            Text(
                                              "Download",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
                if (resourcesIndex == 2) ...[
                  ...streamExamPapers[streams[selectedIndex!]["title"]]!.map(
                        (item) => Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFCBCED3), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),

                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: streams[selectedIndex!]["color"].withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: streams[selectedIndex!]["color"],
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 7),

                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 5,
                                      children: const [
                                        Text("Computer Science"),
                                        Text("•"),
                                        Text("2nd Year"),
                                        Text("•"),
                                        Text("2.3 MB"),
                                      ],
                                    ),
                                    const SizedBox(height: 7),

                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 5,
                                      children: const [
                                        Icon(Icons.star, color: Colors.yellow, size: 20),
                                        Text("4.8"),
                                        Icon(Icons.download),
                                        Text("234 downloads")
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 3,
                                          backgroundColor: const Color(0xFFF6F7FB),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {

                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.download),
                                            SizedBox(width: 8),
                                            Text(
                                              "Download",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),  
 ],
      ),
    ),
  );
}
}