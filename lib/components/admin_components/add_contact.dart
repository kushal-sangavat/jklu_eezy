// // import 'dart:io' show Platform;
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import '../header/header.dart';
// import '../storage.dart';

// class AddContact extends StatefulWidget {
//   const AddContact({super.key});

//   @override
//   State<AddContact> createState() => _AddContactState();
// }

// class _AddContactState extends State<AddContact> {
//   // Controllers for input fields
//   final roleController = TextEditingController();
//   final nameController = TextEditingController();
//   final positionController = TextEditingController();
//   final departmentController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final locationController = TextEditingController();

//   bool isLoading = false;

//   @override
//   void dispose() {
//     roleController.dispose();
//     nameController.dispose();
//     positionController.dispose();
//     departmentController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     locationController.dispose();
//     super.dispose();
//   }

//   // Function to send contact data to backend
//   Future<bool> addContact(Map<String, String> data) async {

//     String baseUrl;
//     // if (Platform.isAndroid) {
//     //   baseUrl = Platform.isAndroid ? "${dotenv.env['PROD_BACKEND_URL']}" : "${dotenv.env['BACKEND_URL']}";
//     // } else if (Platform.isIOS) {
//     //   baseUrl = Platform.isIOS ? "${dotenv.env['PROD_BACKEND_URL']}" : "${dotenv.env['BACKEND_URL']}";
//     // } else {
//     //   baseUrl = Platform.isAndroid ? "${dotenv.env['PROD_BACKEND_URL']}" : "${dotenv.env['BACKEND_URL']}";
//     // }
//     baseUrl = "${dotenv.env['BACKEND_URL']}";
//     final url = Uri.parse("$baseUrl/api/home/addcontact");

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${await getToken()}',
//         },
//         body: json.encode(data),
//       );

//       print('API Response: ${response.body}');
//       return response.statusCode == 201 || response.statusCode == 200;
//     } catch (e) {
//       print('Error adding contact: $e');
//       return false;
//     }
//   }

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
//                   Row(
//                     children: [
//                       const SizedBox(width: 10),
//                       const BackButton(color: Color.fromARGB(255, 3, 59, 105)),
//                       const SizedBox(width: 5),
//                       const Text(
//                         'Back to Contact Directory',
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 3, 59, 105),
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Text(
//                       'Add New Contact',
//                       style: TextStyle(
//                         // color: Color.fromARGB(255, 3, 59, 105),
//                         color:  Color.fromARGB(255, 3, 59, 105),
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Role
//                   // Padding(
//                   //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   //   child: TextField(
//                   //     controller: roleController,
//                   //     decoration: InputDecoration(
//                   //       labelText: 'Role',
//                   //        hintText: 'faculty, health, mess, admin, security',
//                   //       border: OutlineInputBorder(
//                   //         borderRadius: BorderRadius.circular(8.0),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),

//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: DropdownButtonFormField<String>(
//                       value: null, // you can set default like 'faculty'
//                       decoration: InputDecoration(
//                         labelText: 'Role',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       hint: const Text('Select role'),
//                       items: const [
//                         DropdownMenuItem(value: 'faculty', child: Text('Faculty')),
//                         DropdownMenuItem(value: 'health', child: Text('Health')),
//                         DropdownMenuItem(value: 'mess', child: Text('Mess')),
//                         DropdownMenuItem(value: 'admin', child: Text('Admin')),
//                         DropdownMenuItem(value: 'security', child: Text('Security')),
//                       ],
//                       onChanged: (value) {
//                         if (value != null) {
//                           roleController.text = value; // store the selected value in controller
//                         }
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Name
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: nameController,
//                       decoration: InputDecoration(
//                         labelText: 'Name',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Position
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: positionController,
//                       decoration: InputDecoration(
//                         labelText: 'Position',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Department / Group
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: departmentController,
//                       decoration: InputDecoration(
//                         labelText: 'Department',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Phone
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: phoneController,
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Email
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Location
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: TextField(
//                       controller: locationController,
//                       decoration: InputDecoration(
//                         labelText: 'Location',
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
//                       onPressed: isLoading
//                           ? null
//                           : () async {
//                               setState(() => isLoading = true);

//                               final newContactData = {
//                                 'role': roleController.text.trim(),
//                                 'name': nameController.text.trim(),
//                                 'position': positionController.text.trim(),
//                                 'department': departmentController.text.trim(),
//                                 'phone': phoneController.text.trim(),
//                                 'email': emailController.text.trim(),
//                                 'location': locationController.text.trim(),
//                               };

//                               bool success = await addContact(newContactData);

//                               setState(() => isLoading = false);

//                               if (success) {
//                                 Navigator.pop(context);
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Failed to add contact'),
//                                   ),
//                                 );
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 3, 59, 105),
//                         padding: const EdgeInsets.symmetric(vertical: 15.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.save, color: Colors.white),
//                           const SizedBox(width: 10),
//                           Text(
//                             isLoading ? 'Saving...' : 'Save Contact',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
























import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../header/header.dart';
import '../storage.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final roleController = TextEditingController();
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();

  bool isLoading = false;
  String? selectedRole;

  @override
  void dispose() {
    roleController.dispose();
    nameController.dispose();
    positionController.dispose();
    departmentController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<bool> addContact(Map<String, String> data) async {
    final baseUrl = "${dotenv.env['BACKEND_URL']}";
    final url = Uri.parse("$baseUrl/api/home/addcontact");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getToken()}',
        },
        body: json.encode(data),
      );

      print('API Response: ${response.body}');
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error adding contact: $e');
      return false;
    }
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Row
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blueAccent),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Back to Contact Directory',
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
                          'Add New Contact',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Dropdown Role
                      _buildDropdown(),

                      const SizedBox(height: 20),
                      _buildTextField(nameController, 'Full Name', Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(positionController, 'Position / Title', Icons.work),
                      const SizedBox(height: 15),
                      _buildTextField(departmentController, 'Department / Group', Icons.business_center),
                      const SizedBox(height: 15),
                      _buildTextField(phoneController, 'Phone Number', Icons.phone, keyboard: TextInputType.phone),
                      const SizedBox(height: 15),
                      _buildTextField(emailController, 'Email Address', Icons.email, keyboard: TextInputType.emailAddress),
                      const SizedBox(height: 15),
                      _buildTextField(locationController, 'Office Location', Icons.location_on),
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
                              : () async {
                                  setState(() => isLoading = true);

                                  final newContactData = {
                                    'role': roleController.text.trim(),
                                    'name': nameController.text.trim(),
                                    'position': positionController.text.trim(),
                                    'department': departmentController.text.trim(),
                                    'phone': phoneController.text.trim(),
                                    'email': emailController.text.trim(),
                                    'location': locationController.text.trim(),
                                  };

                                  final success = await addContact(newContactData);
                                  setState(() => isLoading = false);

                                  if (success && mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Contact added successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Failed to add contact.'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                },
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: Text(
                            isLoading ? 'Saving...' : 'Save Contact',
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

  // Dropdown with styling
  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      onChanged: (value) {
        setState(() {
          selectedRole = value;
          roleController.text = value ?? '';
        });
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_tree, color: Colors.blueAccent),
        labelText: 'Select Role',
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
      items: const [
        DropdownMenuItem(value: 'faculty', child: Text('Faculty')),
        DropdownMenuItem(value: 'health', child: Text('Health')),
        DropdownMenuItem(value: 'mess', child: Text('Mess')),
        DropdownMenuItem(value: 'admin', child: Text('Admin')),
        DropdownMenuItem(value: 'security', child: Text('Security')),
        DropdownMenuItem(value: 'hostel', child: Text('Hostel')),

      ],
    );
  }

  // Styled text fields
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
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
