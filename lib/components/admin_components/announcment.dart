// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:jklu_eezy/components/storage.dart';
// import '../header/header.dart';
// import '../../pages/announcements.dart';

// class Announcement extends StatefulWidget {
//   const Announcement({super.key});

//   @override
//   State<Announcement> createState() => _AnnouncementState();
// }

// class _AnnouncementState extends State<Announcement> {
//   // Controllers
//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController subtitleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController priorityController = TextEditingController();

//   String? selectedPriority; // for dropdown
//   String? selectedCategory; // for dropdown


// Future<void> addAnnouncement() async {
//   final token = await getToken();
//   String baseUrl = "${dotenv.env['BACKEND_URL']}";
  
//   final url = Uri.parse('$baseUrl/api/home/addannouncements');

//   final body = jsonEncode({
//     "category": categoryController.text,
//     "priority": priorityController.text,
//     "title": titleController.text,
//     "subtitle": subtitleController.text,
//     "description": descriptionController.text,
//   });

//   try {
//     final response = await http.post(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         if (token != null) "Authorization": "Bearer $token",
//       },
//       body: body,
//     );

//     if (response.statusCode == 201) {
//       // ✅ Success
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Announcement added successfully!')),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Announcements(isAdmin: true)),
//       );
//     } else {
//       // ❌ Failed
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed: ${response.body}')),
//       );
//     }
//   } catch (e) {
//     // ⚠️ Error
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: $e')),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const Header(),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),

//                   // Back Row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(width: 10),
//                       const BackButton(color: Color(0xFF033B69)),
//                       const Text(
//                         'Back to Contact Directory',
//                         style: TextStyle(
//                           color: Color(0xFF033B69),
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Title
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Text(
//                       'Add New Announcement',
//                       style: TextStyle(
//                         color: Color(0xFF033B69),
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Category Field
//                   // Padding(
//                   //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   //   child: TextField(
//                   //     controller: categoryController,
//                   //     decoration: InputDecoration(
//                   //       labelText: 'Category',
//                   //       hintText: 'Event, Academic, Social, Hostel, Mess, etc.',
//                   //       border: OutlineInputBorder(
//                   //         borderRadius: BorderRadius.circular(8.0),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),


//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: DropdownButtonFormField<String>(
//                       value: selectedCategory,
//                       decoration: InputDecoration(
//                         labelText: 'Category',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       hint: const Text('Select Category'),
//                       items: const [
//                         DropdownMenuItem(value: 'Event', child: Text('Event')),
//                         DropdownMenuItem(value: 'Academic', child: Text('Academic')),
//                         DropdownMenuItem(value: 'Social', child: Text('Social')),
//                         DropdownMenuItem(value: 'Hostel', child: Text('Hostel')),
//                         DropdownMenuItem(value: 'Mess', child: Text('Mess')),
//                       ],
//                       onChanged: (value) {
//                         setState(() {
//                           selectedCategory = value;
//                           categoryController.text = value ?? '';
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Priority Dropdown
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: DropdownButtonFormField<String>(
//                       value: selectedPriority,
//                       decoration: InputDecoration(
//                         labelText: 'Priority',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       hint: const Text('Select Priority'),
//                       items: const [
//                         DropdownMenuItem(value: 'High', child: Text('High')),
//                         DropdownMenuItem(value: 'Medium', child: Text('Medium')),
//                         DropdownMenuItem(value: 'Low', child: Text('Low')),
//                       ],
//                       onChanged: (value) {
//                         setState(() {
//                           selectedPriority = value;
//                           priorityController.text = value ?? '';
//                         });
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Title Field
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: titleController,
//                       decoration: InputDecoration(
//                         labelText: 'Title',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Subtitle Field
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: subtitleController,
//                       decoration: InputDecoration(
//                         labelText: 'Subtitle',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Description
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: descriptionController,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         labelText: 'Description',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // Save Button
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (titleController.text.isEmpty ||
//                           descriptionController.text.isEmpty ||
//                           selectedCategory == null ||
//                           selectedPriority == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Please fill all fields')),
//                         );
//                       } else {
//                         addAnnouncement(); // ✅ Call POST request
//                       }
//                         // Handle save
//                         print("Saved Announcement:");
//                         print("Category: ${categoryController.text}");
//                         print("Priority: ${priorityController.text}");
//                         print("Title: ${titleController.text}");
                        
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             backgroundColor: Colors.green,
//                             content: Text('Announcement added successfully!'),
//                           ),
//                         );

//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF033B69),
//                         padding: const EdgeInsets.symmetric(vertical: 15.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.save, color: Colors.white),
//                           SizedBox(width: 10),
//                           Text(
//                             'Save Announcement',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

































import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jklu_eezy/components/storage.dart';
import '../header/header.dart';
import '../../pages/announcements.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  String? selectedPriority;
  String? selectedCategory;
  bool isLoading = false;

  Future<void> addAnnouncement() async {
    final token = await getToken();
    String baseUrl = "${dotenv.env['BACKEND_URL']}";
    final url = Uri.parse('$baseUrl/api/home/addannouncements');

    final body = jsonEncode({
      "category": categoryController.text,
      "priority": priorityController.text,
      "title": titleController.text,
      "subtitle": subtitleController.text,
      "description": descriptionController.text,
    });

    try {
      setState(() => isLoading = true);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: body,
      );

      setState(() => isLoading = false);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Announcement added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Announcements(isAdmin: true)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: ${response.body}')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    categoryController.dispose();
    titleController.dispose();
    subtitleController.dispose();
    descriptionController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Back Row
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blueAccent),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Back to Announcements',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Title
                      const Center(
                        child: Text(
                          'Add New Announcement',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Category
                      _buildDropdown(
                        label: "Category",
                        icon: Icons.category,
                        value: selectedCategory,
                        items: const [
                          DropdownMenuItem(value: 'Event', child: Text('Event')),
                          DropdownMenuItem(value: 'Academic', child: Text('Academic')),
                          DropdownMenuItem(value: 'Social', child: Text('Social')),
                          DropdownMenuItem(value: 'Hostel', child: Text('Hostel')),
                          DropdownMenuItem(value: 'Mess', child: Text('Mess')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                            categoryController.text = value ?? '';
                          });
                        },
                      ),

                      const SizedBox(height: 15),

                      // Priority
                      _buildDropdown(
                        label: "Priority",
                        icon: Icons.flag,
                        value: selectedPriority,
                        items: const [
                          DropdownMenuItem(value: 'High', child: Text('High')),
                          DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                          DropdownMenuItem(value: 'Low', child: Text('Low')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedPriority = value;
                            priorityController.text = value ?? '';
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      _buildTextField(titleController, 'Title', Icons.title),
                      const SizedBox(height: 15),

                      _buildTextField(subtitleController, 'Subtitle', Icons.subtitles),
                      const SizedBox(height: 15),

                      _buildTextField(descriptionController, 'Description', Icons.description, maxLines: 3),

                      const SizedBox(height: 30),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (titleController.text.isEmpty ||
                                      descriptionController.text.isEmpty ||
                                      selectedCategory == null ||
                                      selectedPriority == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please fill all fields.'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  } else {
                                    addAnnouncement();
                                  }
                                },
                          icon: const Icon(Icons.send, color: Colors.white),
                          label: Text(
                            isLoading ? 'Saving...' : 'Save Announcement',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Dropdown
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
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
      items: items,
    );
  }

  // Reusable Text Field
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
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
    );
  }
}
