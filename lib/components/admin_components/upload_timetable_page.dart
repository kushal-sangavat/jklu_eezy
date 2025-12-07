
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:path/path.dart';
// // import 'dart:convert';

// // const String BACKEND_URL = "http://localhost:3000";

// // class UploadTimetablePage extends StatefulWidget {
// //   const UploadTimetablePage({super.key});

// //   @override
// //   State<UploadTimetablePage> createState() => _UploadTimetablePageState();
// // }

// // class _UploadTimetablePageState extends State<UploadTimetablePage> {
// //   final _formKey = GlobalKey<FormState>();
// //   File? _selectedImage;

// //   // Dynamic Lists
// //   List<String> courses = ["B.Tech", "MBA", "BCA"];
// //   List<String> years = ["1st Year", "2nd Year", "3rd Year", "4th Year"];

// //   String? selectedCourse;
// //   String? selectedYear;

// //   // ---------------- IMAGE PICKER ----------------
// //   Future<void> _pickImage() async {
// //     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
// //     if (picked != null) setState(() => _selectedImage = File(picked.path));
// //   }

// //   // ---------------- ADD COURSE / YEAR ----------------
// //   Future<void> _addNewItem(String title, List<String> targetList) async {
// //     final TextEditingController controller = TextEditingController();

// //     await showDialog(
// //       context: this.context,
// //       builder: (context) => AlertDialog(
// //         title: Text("Add $title"),
// //         content: TextField(
// //           controller: controller,
// //           decoration: InputDecoration(
// //             hintText: "Enter $title name",
// //             border: const OutlineInputBorder(),
// //           ),
// //         ),
// //         actions: [
// //           // TextButton(
// //             // onPressed: () => Navigator.pop(context),
// //             // child: const Text("Cancel"),
// //           // ),
// //           ElevatedButton(
// //             onPressed: () {
// //               if (controller.text.trim().isNotEmpty) {
// //                 setState(() => targetList.add(controller.text.trim()));
// //               }
// //               // Navigator.pop(context);
// //             },
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color.fromRGBO(9, 31, 94, 1),
// //             ),
// //             child: const Text("Add"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // ---------------- UPLOAD TIMETABLE ----------------
// //   Future<void> _uploadTimetable() async {
// //     if (!_formKey.currentState!.validate() ||
// //         _selectedImage == null ||
// //         selectedCourse == null ||
// //         selectedYear == null) {
// //       // ScaffoldMessenger.of(context).showSnackBar(
// //         // const SnackBar(content: Text("Please fill all fields")),
// //       // );
// //       return;
// //     }

// //     var uri = Uri.parse("$BACKEND_URL/api/timetable/upload");
// //     var request = http.MultipartRequest('POST', uri);
// //     request.fields['course'] = selectedCourse!;
// //     request.fields['year'] = selectedYear!;
// //     request.files.add(await http.MultipartFile.fromPath(
// //       'file',
// //       _selectedImage!.path,
// //       filename: basename(_selectedImage!.path),
// //     ));

// //     var response = await request.send();
// //     // if (response.statusCode == 201) {
// //     //   ScaffoldMessenger.of(context).showSnackBar(
// //     //     const SnackBar(content: Text("Timetable Uploaded")),
// //     //   );
// //     //   Navigator.pop(context);
// //     // } else {
// //     //   ScaffoldMessenger.of(context).showSnackBar(
// //     //     const SnackBar(content: Text("Upload Failed")),
// //     //   );
// //     // }
// //   }

// //   // ---------------- BUILD UI ----------------
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "Upload Timetable",
// //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
// //         ),
// //         backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
// //         iconTheme: const IconThemeData(color: Colors.white),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             children: [
// //               // ---------- COURSE DROPDOWN ----------
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: DropdownButtonFormField<String>(
// //                       value: selectedCourse,
// //                       decoration: const InputDecoration(
// //                         labelText: "Select Course",
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       items: courses
// //                           .map((course) => DropdownMenuItem(
// //                                 value: course,
// //                                 child: Text(course),
// //                               ))
// //                           .toList(),
// //                       onChanged: (value) => setState(() => selectedCourse = value),
// //                       validator: (v) =>
// //                           v == null ? "Please select a course" : null,
// //                     ),
// //                   ),
// //                   IconButton(
// //                     icon: const Icon(Icons.add_circle, color: Colors.blueAccent),
// //                     onPressed: () => _addNewItem("Course", courses),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 20),

// //               // ---------- YEAR DROPDOWN ----------
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: DropdownButtonFormField<String>(
// //                       value: selectedYear,
// //                       decoration: const InputDecoration(
// //                         labelText: "Select Year",
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       items: years
// //                           .map((year) => DropdownMenuItem(
// //                                 value: year,
// //                                 child: Text(year),
// //                               ))
// //                           .toList(),
// //                       onChanged: (value) => setState(() => selectedYear = value),
// //                       validator: (v) => v == null ? "Please select a year" : null,
// //                     ),
// //                   ),
// //                   IconButton(
// //                     icon: const Icon(Icons.add_circle, color: Colors.blueAccent),
// //                     onPressed: () => _addNewItem("Year", years),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 20),

// //               // ---------- IMAGE PICKER ----------
// //               _selectedImage == null
// //                   ? const Text("No Image Selected")
// //                   : Image.file(_selectedImage!, height: 150),
// //               const SizedBox(height: 20),

// //               ElevatedButton.icon(
// //                 onPressed: _pickImage,
// //                 icon: const Icon(Icons.image),
// //                 label: const Text("Select Image"),
// //               ),
// //               const SizedBox(height: 30),

// //               // ---------- UPLOAD BUTTON ----------
// //               ElevatedButton(
// //                 onPressed: _uploadTimetable,
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
// //                   padding: const EdgeInsets.symmetric(vertical: 15),
// //                 ),
// //                 child: const Text(
// //                   "Upload Timetable",
// //                   style: TextStyle(fontSize: 16, color: Colors.white),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

// const String BACKEND_URL = "http://localhost:3000";

// class UploadTimetablePage extends StatefulWidget {
//   const UploadTimetablePage({super.key});

//   @override
//   State<UploadTimetablePage> createState() => _UploadTimetablePageState();
// }

// class _UploadTimetablePageState extends State<UploadTimetablePage> {
//   final _formKey = GlobalKey<FormState>();
//   File? _selectedImage;

//   // Dynamic Lists
//   List<String> courses = ["B.Tech", "MBA", "BCA"];
//   List<String> years = ["1st Year", "2nd Year", "3rd Year", "4th Year"];
//   List<String> sections = ["A", "B", "C"];

//   String? selectedCourse;
//   String? selectedYear;
//   String? selectedSection;

//   // ---------------- IMAGE PICKER ----------------
//   Future<void> _pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) setState(() => _selectedImage = File(picked.path));
//   }

//   // ---------------- ADD NEW ITEM ----------------
//   Future<void> _addNewItem(String title, List<String> targetList) async {
//     final TextEditingController controller = TextEditingController();

//     await showDialog(
//       context: this.context,
//       builder: (_) => AlertDialog(
//         title: Text("Add $title"),
//         content: TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: "Enter $title name",
//             border: const OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(this.context),
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (controller.text.trim().isNotEmpty) {
//                 setState(() => targetList.add(controller.text.trim()));
//               }
//               Navigator.pop(this.context);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromRGBO(9, 31, 94, 1),
//             ),
//             child: const Text("Add"),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------- UPLOAD TIMETABLE ----------------
//   Future<void> _uploadTimetable() async {
//     if (!_formKey.currentState!.validate() ||
//         _selectedImage == null ||
//         selectedCourse == null ||
//         selectedYear == null ||
//         selectedSection == null) {
//       ScaffoldMessenger.of(this.context).showSnackBar(
//         const SnackBar(content: Text("Please fill all fields")),
//       );
//       return;
//     }

//     var uri = Uri.parse("$BACKEND_URL/api/timetable/upload");
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['course'] = selectedCourse!;
//     request.fields['year'] = selectedYear!;
//     request.fields['section'] = selectedSection!;
//     request.files.add(await http.MultipartFile.fromPath(
//       'file',
//       _selectedImage!.path,
//       filename: basename(_selectedImage!.path),
//     ));

//     var response = await request.send();
//     if (response.statusCode == 201) {
//       ScaffoldMessenger.of(this.context).showSnackBar(
//         const SnackBar(content: Text("Timetable Uploaded Successfully")),
//       );
//       Navigator.pop(this.context);
//     } else {
//       ScaffoldMessenger.of(this.context).showSnackBar(
//         const SnackBar(content: Text("Upload Failed")),
//       );
//     }
//   }

//   // ---------------- BUILD UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Upload Timetable",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // ---------- COURSE DROPDOWN ----------
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                       value: selectedCourse,
//                       decoration: const InputDecoration(
//                         labelText: "Select Course",
//                         border: OutlineInputBorder(),
//                       ),
//                       items: courses
//                           .map((course) => DropdownMenuItem(
//                                 value: course,
//                                 child: Text(course),
//                               ))
//                           .toList(),
//                       onChanged: (value) => setState(() => selectedCourse = value),
//                       validator: (v) =>
//                           v == null ? "Please select a course" : null,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add_circle, color: Colors.blueAccent),
//                     onPressed: () => _addNewItem("Course", courses),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // ---------- YEAR DROPDOWN ----------
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                       value: selectedYear,
//                       decoration: const InputDecoration(
//                         labelText: "Select Year",
//                         border: OutlineInputBorder(),
//                       ),
//                       items: years
//                           .map((year) => DropdownMenuItem(
//                                 value: year,
//                                 child: Text(year),
//                               ))
//                           .toList(),
//                       onChanged: (value) => setState(() => selectedYear = value),
//                       validator: (v) => v == null ? "Please select a year" : null,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add_circle, color: Colors.blueAccent),
//                     onPressed: () => _addNewItem("Year", years),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // ---------- SECTION DROPDOWN ----------
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                       value: selectedSection,
//                       decoration: const InputDecoration(
//                         labelText: "Select Section",
//                         border: OutlineInputBorder(),
//                       ),
//                       items: sections
//                           .map((section) => DropdownMenuItem(
//                                 value: section,
//                                 child: Text(section),
//                               ))
//                           .toList(),
//                       onChanged: (value) =>
//                           setState(() => selectedSection = value),
//                       validator: (v) =>
//                           v == null ? "Please select a section" : null,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add_circle, color: Colors.blueAccent),
//                     onPressed: () => _addNewItem("Section", sections),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // ---------- IMAGE PICKER ----------
//               _selectedImage == null
//                   ? const Text("No Image Selected")
//                   : Image.file(_selectedImage!, height: 150),
//               const SizedBox(height: 20),

//               ElevatedButton.icon(
//                 onPressed: _pickImage,
//                 icon: const Icon(Icons.image),
//                 label: const Text("Select Image"),
//               ),

//               const SizedBox(height: 30),

//               // ---------- UPLOAD BUTTON ----------
//               ElevatedButton(
//                 onPressed: _uploadTimetable,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                 ),
//                 child: const Text(
//                   "Upload Timetable",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




































import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

const String BACKEND_URL = "http://localhost:3000";

class UploadTimetablePage extends StatefulWidget {
  const UploadTimetablePage({super.key});

  @override
  State<UploadTimetablePage> createState() => _UploadTimetablePageState();
}

class _UploadTimetablePageState extends State<UploadTimetablePage> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  List<String> courses = ["B.Tech", "MBA", "BCA"];
  List<String> years = ["1st Year", "2nd Year", "3rd Year", "4th Year"];
  List<String> sections = ["A", "B", "C"];

  String? selectedCourse;
  String? selectedYear;
  String? selectedSection;
  bool isLoading = false;

  // 🖼 Pick image
  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _selectedImage = File(picked.path));
  }

  // ➕ Add new item dialog
  Future<void> _addNewItem(String title, List<String> targetList) async {
    final TextEditingController controller = TextEditingController();

    await showDialog(
      context: this.context,
      builder: (_) => AlertDialog(
        title: Text("Add $title"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter $title name",
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(this.context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() => targetList.add(controller.text.trim()));
              }
              Navigator.pop(this.context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // ☁️ Upload timetable
  Future<void> _uploadTimetable() async {
    if (!_formKey.currentState!.validate() ||
        _selectedImage == null ||
        selectedCourse == null ||
        selectedYear == null ||
        selectedSection == null) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and select an image."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    var uri = Uri.parse("$BACKEND_URL/api/timetable/upload");
    var request = http.MultipartRequest('POST', uri);
    request.fields['course'] = selectedCourse!;
    request.fields['year'] = selectedYear!;
    request.fields['section'] = selectedSection!;
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      _selectedImage!.path,
      filename: basename(_selectedImage!.path),
    ));

    var response = await request.send();
    setState(() => isLoading = false);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        const SnackBar(
          content: Text("Timetable uploaded successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(this.context);
    } else {
      ScaffoldMessenger.of(this.context).showSnackBar(
        const SnackBar(
          content: Text("Upload failed. Try again."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // 🌟 Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text(
          "Upload Timetable",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Add Timetable Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Course Dropdown
                  _buildDropdown(
                    label: "Select Course",
                    icon: Icons.school,
                    value: selectedCourse,
                    items: courses,
                    onChanged: (v) => setState(() => selectedCourse = v),
                    onAdd: () => _addNewItem("Course", courses),
                  ),

                  const SizedBox(height: 15),

                  // Year Dropdown
                  _buildDropdown(
                    label: "Select Year",
                    icon: Icons.calendar_month,
                    value: selectedYear,
                    items: years,
                    onChanged: (v) => setState(() => selectedYear = v),
                    onAdd: () => _addNewItem("Year", years),
                  ),

                  const SizedBox(height: 15),

                  // Section Dropdown
                  _buildDropdown(
                    label: "Select Section",
                    icon: Icons.class_,
                    value: selectedSection,
                    items: sections,
                    onChanged: (v) => setState(() => selectedSection = v),
                    onAdd: () => _addNewItem("Section", sections),
                  ),

                  const SizedBox(height: 25),

                  // Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: _selectedImage == null
                        ? Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.05),
                              border: Border.all(
                                color: Colors.blueAccent.withOpacity(0.4),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate_outlined,
                                    size: 50, color: Colors.blueAccent),
                                SizedBox(height: 10),
                                Text(
                                  "Tap to select timetable image",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImage!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),

                  const SizedBox(height: 30),

                  // Upload Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                      ),
                      onPressed: isLoading ? null : _uploadTimetable,
                      icon: const Icon(Icons.upload_file, color: Colors.white),
                      label: Text(
                        isLoading ? 'Uploading...' : 'Upload Timetable',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable dropdown with + icon
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required VoidCallback onAdd,
  }) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blueAccent),
              labelText: label,
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blueAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            validator: (v) => v == null ? "Required" : null,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.blueAccent, size: 28),
          onPressed: onAdd,
        ),
      ],
    );
  }
}
