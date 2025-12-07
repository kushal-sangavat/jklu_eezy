// import 'package:flutter/material.dart';
// import 'package:jklu_eezy/components/admin_components/admin_lostNfound.dart';
// import 'package:jklu_eezy/components/header/header.dart';
// import 'package:jklu_eezy/components/user_components/LostNFound/block_lostNfound.dart';

// class Lostnfound extends StatefulWidget {
//   final bool isAdmin;
//   const Lostnfound({super.key, this.isAdmin = false});

//   @override
//   State<Lostnfound> createState() => _LostnfoundState();
// }


// class _LostnfoundState extends State<Lostnfound> {
//   @override
// void initState() {
//   super.initState();
//   itemsFuture = fetchLostFoundItems();
// }
//   @override
//   Future<List<dynamic>>? itemsFuture;

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: Column(
//           children: [
//             Header(),
//             const SizedBox(height: 12),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   const Text(
//                     "Back to Dashboard",
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromRGBO(9, 31, 94, 1.0),
//                     ),
//                   ),
//                   const Spacer(),

                  







//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//                     ),
//                     icon: const Icon(Icons.add, color: Colors.white),
//                     label: const Text(
//                       "Add",
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const AdminLostNFound()),
//                       );
//                     },
//                   ),















//                 ],
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 padding: const EdgeInsets.only(bottom: 16.0,left: 16,right: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//               Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text('Lost &', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                       Text('Found', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                       Text('Help recover lost\nitems on campus', style: TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                   const Spacer(),
//                   if (widget.isAdmin)
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
//                           minimumSize: const Size(100, 50),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         icon: const Icon(Icons.add, color: Colors.white),
//                         // onPressed: () {
//                         //   Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(builder: (context) => const AdminLostNFound()),
//                         //   ).then((_) {
//                         //     // Refresh when returning
//                         //     setState(() {}); // trigger refresh if needed
//                         //   });
//                         // },

//                         onPressed: () async {
//                           bool success = await uploadLostFoundItem(
//                             titleController.text,
//                             descriptionController.text,
//                             locationController.text,
//                             dateController.text,
//                             _selectedImage!.path,
//                           );

//                           if (success) {
//                             Navigator.pop(context);
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("Upload failed")),
//                             );
//                           }
//                         label: const Text('Report Found Item', style: TextStyle(color: Colors.white)),
//                         }

//                       ),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: const Color.fromARGB(255, 245, 230, 94)),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color.fromARGB(255, 253, 255, 209),
//                         spreadRadius: 1,
//                         blurRadius: 3,
//                         offset: const Offset(0, 1), // changes position of shadow
//                       ),    
//                     ],
//                   ),
//                   child: const Text(
//                   'Note: Only Wardens, ARC Heads, and Guard Heads can report found items. If you\'ve lost something, contact the security office or check this page regularly.',
//                   style: TextStyle(fontSize: 14, color: Colors.red),
//                 )
                
//                 ),
//               ),
//               const SizedBox(height: 16),
//                 // const BlockLostnfound()
//                 FutureBuilder(
//   future: itemsFuture,
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//       return const Text("No lost & found items yet.");
//     }

//     List items = snapshot.data!;

//     return Column(
//       children: items.map((item) {
//         return BlockLostnfound(
//           title: item['title'],
//           description: item['description'],
//           location: item['location'],
//           dateFound: item['dateFound'],
//           imageUrl: "${dotenv.env['BACKEND_URL']}${item['imageUrl']}",
//         );
//       }).toList(),
//     );
//   },
// ),



              
//                     // Add your lost & found content here
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }












































import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jklu_eezy/apicall/lostfound_api.dart';
import 'package:jklu_eezy/components/admin_components/admin_lostNfound.dart';
import 'package:jklu_eezy/components/header/header.dart';
import 'package:jklu_eezy/components/user_components/LostNFound/block_lostNfound.dart';

class Lostnfound extends StatefulWidget {
  final bool isAdmin;
  const Lostnfound({super.key, this.isAdmin = false});

  @override
  State<Lostnfound> createState() => _LostnfoundState();
}

class _LostnfoundState extends State<Lostnfound> {
  Future<List<dynamic>>? itemsFuture;

  @override
  void initState() {
    super.initState();
    itemsFuture = fetchLostFoundItems();  // 🔥 Fetch items
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            const SizedBox(height: 12),

            // 🔹 BACK BUTTON + ADD BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
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

                  // 🔹 Only Admin can add
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(9, 31, 94, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AdminLostNFound()),
                      );
                      setState(() {
                        itemsFuture = fetchLostFoundItems(); // 🔄 refresh data
                      });
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header text
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Lost &', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('Found', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('Help recover lost\nitems on campus', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Note box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 245, 230, 94)),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 253, 255, 209),
                      ),
                      child: const Text(
                        'Note: Only Wardens, ARC Heads, and Guard Heads can report found items.',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 🔥 FUTUREBUILDER — items list
                    FutureBuilder(
                      future: itemsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Text("No lost & found items yet.");
                        }

                        List items = snapshot.data!;

                        return Column(
                          children: items.map((item) {
                            return BlockLostnfound(
                              title: item['title'],
                              description: item['description'],
                              location: item['location'],
                              dateFound: item['dateFound'],
                              imageUrl: "${dotenv.env['BACKEND_URL']}${item['imageUrl']}",
                            );
                          }).toList(),
                        );
                      },
                    ),
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
