// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class admin_lostNfound extends StatefulWidget {
//   const admin_lostNfound({super.key});

//   @override
//   State<admin_lostNfound> createState() => _admin_lostNfoundState();
// }

// class _admin_lostNfoundState extends State<admin_lostNfound> {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();


//   File? _selectedImage; // To store the picked image
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera); // or ImageSource.camera

//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }
  
//   @override
//   void dispose() {
//   titleController.dispose();
//   descriptionController.dispose();
//   locationController.dispose();
//   dateController.dispose();
//   super.dispose();
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Lost & Found Item'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: locationController,
//                 decoration: const InputDecoration(labelText: 'Location Found'),
//               ),
//               TextField(
//                 controller: dateController,
//                 decoration: const InputDecoration(labelText: 'Date Found'),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: const Text('Pick Image'),
//               ),
//               if (_selectedImage != null) ...[
//                 const SizedBox(height: 16),
//                 Image.file(_selectedImage!),
//               ],
//               const SizedBox(height: 24),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle form submission
//                   },
//                   child: const Text('Submit'),
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
import 'package:jklu_eezy/apicall/lostfound_api.dart';

class AdminLostNFound extends StatefulWidget {
  const AdminLostNFound({super.key});

  @override
  State<AdminLostNFound> createState() => _AdminLostNFoundState();
}

class _AdminLostNFoundState extends State<AdminLostNFound> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 30,
          children: [
            _buildPickerOption(Icons.camera_alt, "Camera", ImageSource.camera),
            _buildPickerOption(Icons.photo_library, "Gallery", ImageSource.gallery),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption(IconData icon, String label, ImageSource source) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueAccent.withOpacity(0.1),
          child: IconButton(
            icon: Icon(icon, color: Colors.blueAccent, size: 28),
            onPressed: () async {
              final pickedFile = await _picker.pickImage(source: source);
              if (pickedFile != null) {
                setState(() {
                  _selectedImage = File(pickedFile.path);
                });
              }
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: const Text(
          'Add Lost & Found Item',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header
                Text(
                  'Upload Lost Item Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                ),
                const SizedBox(height: 25),

                // Image Picker
                GestureDetector(
                  onTap: _pickImage,
                  child: _selectedImage == null
                      ? Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.blueAccent.withOpacity(0.4), width: 1.5),
                            color: Colors.blueAccent.withOpacity(0.05),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 50, color: Colors.blueAccent),
                              SizedBox(height: 8),
                              Text('Tap to upload image',
                                  style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _selectedImage!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(height: 25),

                // Text Fields
                _buildTextField(titleController, 'Item Title', Icons.title),
                const SizedBox(height: 15),
                _buildTextField(descriptionController, 'Description', Icons.description, maxLines: 3),
                const SizedBox(height: 15),
                _buildTextField(locationController, 'Location Found', Icons.location_on),
                const SizedBox(height: 15),
                _buildTextField(dateController, 'Date Found', Icons.calendar_today),

                const SizedBox(height: 25),

                // Submit Button
                SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
    ),
    onPressed: () async {
      if (titleController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          locationController.text.isEmpty ||
          dateController.text.isEmpty ||
          _selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all fields and upload an image.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      bool success = await uploadLostFoundItem(
        title: titleController.text,
        description: descriptionController.text,
        location: locationController.text,
        dateFound: dateController.text,
        imageFile: _selectedImage!,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item uploaded successfully!")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Upload failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
    icon: const Icon(Icons.send, color: Colors.white),
    label: const Text(
      'Submit Item',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable TextField Builder
  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {int maxLines = 1}) {
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
