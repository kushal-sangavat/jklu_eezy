import 'package:flutter/material.dart';
import 'package:jklu_eezy/components/header/header.dart';
import 'package:jklu_eezy/apicall/auth_utils.dart';
import 'package:jklu_eezy/apicall/laundry_api.dart';


class LaundryPage extends StatefulWidget {
  const LaundryPage({super.key});

  @override
  State<LaundryPage> createState() => _LaundryPageState();
}

class _LaundryPageState extends State<LaundryPage> {
  bool isAdmin = false;
  Future<List<dynamic>>? laundryFuture;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final admin = await checkAdminStatus();
    setState(() {
      isAdmin = admin;
      laundryFuture = _loadLaundry();
    });
  }

  Future<List<dynamic>> _loadLaundry() async {
    return isAdmin ? fetchAllLaundry() : fetchMyLaundry();
  }

  /// Admin – Raise Laundry Request
  void _openCreateLaundryDialog() {
    final TextEditingController cardCtrl = TextEditingController();
    final TextEditingController weightCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: StatefulBuilder(
              builder: (context, setStateDialog) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Raise Laundry Request",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Text("Card Number", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: cardCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter user's laundry card number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text("Weight (kg)", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: weightCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter total weight of clothes",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff092075),
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text("Create Request",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onPressed: () async {
                          if (cardCtrl.text.isEmpty ||
                              weightCtrl.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Fill all fields")));
                            return;
                          }

                          bool ok = await createLaundryRequest(
                            cardNumber: cardCtrl.text,
                            weight: double.tryParse(weightCtrl.text) ?? 0,
                          );

                          if (ok) {
                            Navigator.pop(context);
                            setState(() => laundryFuture = _loadLaundry());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Laundry request created"),
                                  backgroundColor: Colors.green),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// 32 Box Laundry Usage Indicator
  Widget _usageIndicator(int used) {
    const total = 32;
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(total, (i) {
        if (i < used) {
          return Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4)),
          );
        } else {
          return Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Header(),

            // Top Section
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  const Text(
                    "Laundry Service",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (isAdmin)
                    ElevatedButton.icon(
                      onPressed: _openCreateLaundryDialog,
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text("Raise Request",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff092075),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: laundryFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final list = snapshot.data!;

                  if (list.isEmpty) {
                    return const Center(child: Text("No laundry requests yet"));
                  }

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) =>
                        _laundryCard(list[i] as Map<String, dynamic>),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MAIN CARD UI
  Widget _laundryCard(Map<String, dynamic> item) {
    final status = item["status"]; // pending, in-progress, done, completed

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 6, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Card #: ${item['cardNumber']}",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Weight: ${item['weight']} kg"),
          const SizedBox(height: 6),

          // Status label
          Chip(
            label: Text(status.toUpperCase()),
            backgroundColor: status == "completed"
                ? Colors.green.shade200
                : status == "in-progress"
                    ? Colors.yellow.shade200
                    : Colors.orange.shade200,
          ),

          const SizedBox(height: 10),

          _usageIndicator(item["usedCount"]),

          const SizedBox(height: 10),

          // Role-based Action Buttons
          if (!isAdmin && status == "pending")
            ElevatedButton(
              onPressed: () async {
                await acceptLaundry(item["_id"]);
                setState(() => laundryFuture = _loadLaundry());
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Accept Request"),
            ),

          if (isAdmin && status == "in-progress")
            ElevatedButton(
              onPressed: () async {
                await markLaundryDone(item["_id"]);
                setState(() => laundryFuture = _loadLaundry());
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Mark as Done"),
            ),

          if (!isAdmin && status == "done")
            ElevatedButton(
              onPressed: () async {
                await completeLaundryByUser(item["_id"]);
                setState(() => laundryFuture = _loadLaundry());
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text("Pickup Done"),
            ),
        ],
      ),
    );
  }
}
