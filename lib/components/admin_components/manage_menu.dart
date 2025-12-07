import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:jklu_eezy/components/storage.dart';


class ManageWeeklyMenu extends StatefulWidget {
  const ManageWeeklyMenu({super.key});

  @override
  State<ManageWeeklyMenu> createState() => _ManageWeeklyMenuState();
}

class _ManageWeeklyMenuState extends State<ManageWeeklyMenu> {
  DateTime? fromDate;
  DateTime? toDate;
  final notesController = TextEditingController();
bool isLoading = false;



Future<bool> saveWeeklyMenuToBackend(Map<String, dynamic> data) async {
  final baseUrl = "${dotenv.env['BACKEND_URL']}";
  final url = Uri.parse("$baseUrl/api/menu/add");

  print("🔵 --- SENDING MENU DATA ---");
  print(jsonEncode(data));
  print("URL: $url");

  try {
    final token = await getToken();
    print("TOKEN: $token");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );

    print("🔴 --- RESPONSE STATUS: ${response.statusCode}");
    print("🟡 --- RESPONSE BODY: ${response.body}");

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    print("❌ ERROR: $e");
    return false;
  }
}



  // To expand or collapse each day
  Map<String, bool> expanded = {
    "Sunday": false,
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
  };

  // 4 dish inputs for each day
  Map<String, Map<String, TextEditingController>> meals = {};

  @override
  void initState() {
    super.initState();
    for (var day in expanded.keys) {
      meals[day] = {
        "Breakfast": TextEditingController(),
        "Lunch": TextEditingController(),
        "Snacks": TextEditingController(),
        "Dinner": TextEditingController(),
      };
    }
  }

  Future<void> pickDate(Function(DateTime) onSelect) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 1),
      initialDate: today,
    );
    if (picked != null) {
      onSelect(picked);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Manage Menu"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // -------------------------------------------------------------
            // 🌟 DATE RANGE PICKER BLOCK
            // -------------------------------------------------------------
            _dateBox("From Date", fromDate, () => pickDate((d) => fromDate = d)),
            const SizedBox(height: 12),
            _dateBox("To Date", toDate, () => pickDate((d) => toDate = d)),
            const SizedBox(height: 20),

            // -------------------------------------------------------------
            // 🌟 7 DAYS BLOCKS (Sunday → Saturday)
            // -------------------------------------------------------------
            ...expanded.keys.map((day) => _dayBlock(day)).toList(),

            const SizedBox(height: 20),

            // -------------------------------------------------------------
            // 🌟 NOTES BLOCK
            // -------------------------------------------------------------
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                labelText: "Notes",
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.note_alt, color: Colors.blueAccent),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading
    ? null
    : () async {
        if (fromDate == null || toDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Select both dates")),
          );
          return;
        }

        setState(() => isLoading = true);

        // Create "days" JSON
        Map<String, dynamic> daysJson = {};
        meals.forEach((day, mealControllers) {
          daysJson[day] = {
            "breakfast": mealControllers["Breakfast"]!.text,
            "lunch": mealControllers["Lunch"]!.text,
            "snacks": mealControllers["Snacks"]!.text,
            "dinner": mealControllers["Dinner"]!.text,
          };
        });

        // Final Body
        final menuData = {
          // "fromDate": fromDate!.toIso8601String(),
          // "toDate": toDate!.toIso8601String(),
          "fromDate": DateTime(fromDate!.year, fromDate!.month, fromDate!.day).toIso8601String(),
          "toDate": DateTime(toDate!.year, toDate!.month, toDate!.day).toIso8601String(),

          "days": daysJson,
          "notes": notesController.text.trim(),
        };

        bool success = await saveWeeklyMenuToBackend(menuData);
        setState(() => isLoading = false);

        if (!mounted) return;

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Menu saved successfully!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to save menu"),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },

                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "Save Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // 📌 DATE PICKER UI BOX
  // -------------------------------------------------------------
  Widget _dateBox(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.date_range, color: Colors.blueAccent),
            const SizedBox(width: 12),
            Text(
              date == null ? label : "${date.day}/${date.month}/${date.year}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // 📌 DAY EXPANDABLE BLOCK
  // -------------------------------------------------------------
  Widget _dayBlock(String day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              day,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 18,
              ),
            ),
            trailing: Icon(
              expanded[day]! ? Icons.expand_less : Icons.expand_more,
              color: Colors.blueAccent,
              size: 30,
            ),
            onTap: () {
              setState(() {
                expanded[day] = !expanded[day]!;
              });
            },
          ),

    if (expanded[day]!)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            _mealInput(day, "Breakfast"),
            const SizedBox(height: 10),
            _mealInput(day, "Lunch"),
            const SizedBox(height: 10),
            _mealInput(day, "Snacks"),
            const SizedBox(height: 10),
            _mealInput(day, "Dinner"),
          ],
        ),
      ),
  ],
),
    );
  }

  // -------------------------------------------------------------
  // 📌 MEAL INPUT FIELD
  // -------------------------------------------------------------
  Widget _mealInput(String day, String meal) {
    return TextField(
      controller: meals[day]![meal],
      decoration: InputDecoration(
        labelText: meal,
        prefixIcon: const Icon(Icons.fastfood, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
