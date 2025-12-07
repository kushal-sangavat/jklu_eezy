import 'package:flutter/material.dart';
import 'package:jklu_eezy/apicall/auth_utils.dart';
import 'package:jklu_eezy/components/header/header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jklu_eezy/components/home/service_bloc.dart';
import 'package:jklu_eezy/pages/LostNFound.dart';
import 'package:jklu_eezy/pages/announcements.dart';
import 'package:jklu_eezy/pages/complaint_page.dart';
import 'package:jklu_eezy/pages/contact_directory.dart';
import 'package:jklu_eezy/pages/mess.dart';
import 'package:jklu_eezy/pages/quick_actions.dart';
import 'package:jklu_eezy/pages/study_material.dart';
import 'package:jklu_eezy/pages/time_table.dart';
import 'package:url_launcher/url_launcher.dart';
import '../apicall/userdetails.dart';
import 'dart:io';




//--------------------Quick App Widget----------------

Widget quickApp({
  required String logo,
  required String name,
  required String appUrl,   // scheme
  required String storeUrl, // play store / app store link
}) {
  return GestureDetector(
    onTap: () async {
      final uri = Uri.parse(appUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(Uri.parse(storeUrl), mode: LaunchMode.externalApplication);
      }
    },
    child: Column(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(10),
          child: Image.asset(logo, fit: BoxFit.contain),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}



//--------------------Add URL launcher helper----------------
Future<void> openAppOrStore({
  required String androidScheme,
  required String iosScheme,
  required String androidStore,
  required String iosStore,
}) async {
  final scheme = Platform.isAndroid ? androidScheme : iosScheme;
  final store = Platform.isAndroid ? androidStore : iosStore;

  // Validate scheme format
  if (!scheme.contains("://")) {
    print("❌ Invalid scheme for platform: $scheme");
    await launchUrl(Uri.parse(store), mode: LaunchMode.externalApplication);
    return;
  }

  final uri = Uri.parse(scheme);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    await launchUrl(Uri.parse(store), mode: LaunchMode.externalApplication);
  }
}


//-----------------------------------------------------------------------




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await UserService.instance.loadUser(); // 👈 fetch user details
    setState(() {
      isLoading = false;
    });
  }
  final userRole = UserService.instance.role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(249, 255, 255, 255),
      body: Column(
        children: [
          // Header stays fixed
          Header(),

          // Everything else scrolls
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Welcome Card
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 300.0),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 3, 33, 85),
                            Color.fromARGB(255, 10, 231, 128)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Icon Box
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF466892), Color(0xFF5C859F)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.graduationCap,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Welcome to ",
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "JKLU Eezy",
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Your complete campus companion",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Text(
                            "Access all campus services, contact information, "
                            "mess management, study materials, and more in one unified "
                            "platform designed for JKLU students.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Stats Grid
                  GridView.count(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard("150+", "Faculty Members"),
                      _buildStatCardWithIcon("4.2", "Mess Rating", Icons.star, Colors.green),
                      _buildStatCard("50+", "Study Resources"),
                      _buildStatCard("24/7", "Support"),
                    ],
                  ),







//-----------------------------------------------------------------------------------------------
// 🔹 Quick Apps Section — 4 per row
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Quick Apps",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: quickApp(
                      logo: "assets/logos/outlook.png",
                      name: "Outlook",
                      appUrl: "ms-outlook://",
                      storeUrl: Platform.isAndroid
                          ? "https://play.google.com/store/apps/details?id=com.microsoft.office.outlook"
                          : "https://apps.apple.com/app/microsoft-outlook/id951937596",
                    ),
          ),
          Expanded(
            child: quickApp(
  logo: "assets/logos/Mtop.png",
  name: "TCS iON",
  appUrl: "intent://#Intent;package=com.tcsion.mtop;end",
  storeUrl: Platform.isAndroid
      ? "https://play.google.com/store/apps/details?id=com.tcsion.mtop"
      : "https://apps.apple.com/app/tcs-ion/id1437138937",
),
          ),
          Expanded(
            child: quickApp(
  logo: "assets/logos/teams.png",
  name: "Teams",
  appUrl: "msteams://",
  storeUrl: Platform.isAndroid
      ? "https://play.google.com/store/apps/details?id=com.microsoft.teams"
      : "https://apps.apple.com/app/microsoft-teams/id1113153706",
),
          ),
          Expanded(
            child: quickApp(
  logo: "assets/logos/canvas.png",
  name: "Canvas",
  appUrl: "canvas-student://",
  storeUrl: Platform.isAndroid
      ? "https://play.google.com/store/apps/details?id=com.instructure.candroid"
      : "https://apps.apple.com/app/canvas-student/id480883488",
),
          ),
Expanded(
  child: quickApp(
    logo: "assets/logos/Linkedin.png",
    name: "LinkedIn",
    appUrl: "linkedin://",
    storeUrl: Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.linkedin.android"
        : "https://apps.apple.com/app/linkedin/id288429040",
  ),
),

        ],
      ),
    ],
  ),
),


//-----------------------------------------------------------------------------------------------
                  const SizedBox(height: 10),

                  // Services
                  ServiceBloc(
                    title: 'Contact Directory',
                    description: 'Faculty, staff, and service contact',
                    icon: Icons.contacts_outlined,
                    onTap: () async{
                      bool isAdmin = await checkAdminStatus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactDirectory(isAdmin: isAdmin)),
                      );
                    },
                  ),
                  ServiceBloc(
                    title: 'Announcements',
                    description: "Latest news and updates",
                    icon: Icons.announcement_outlined,
                    onTap: () async{
                      bool isAdmin = await checkAdminStatus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Announcements(isAdmin: isAdmin)),
                      );
                    },
                  ),
                  ServiceBloc(
                    title: "Mess Management",
                    description: "Menu, timings, and meal tickets",
                    icon: Icons.restaurant_menu_outlined,
                    onTap: () async{
                      bool isAdmin = await checkAdminStatus();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MessManagementPage(isAdmin: isAdmin)),);
                    },
                  ),
                  ServiceBloc(
                    title: "Study Materials",
                    description: "Papers, e-books, and resources",
                    icon: Icons.menu_book_outlined,
                    onTap: () async{
                      bool isAdmin = await checkAdminStatus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudyMaterial(isAdmin: isAdmin)),
                      );
                    },
                  ),

                  ServiceBloc(
                    title: "Lost & Found",
                    description: "Report and recover items",
                    icon: Icons.search,
                    onTap: () async{
                      bool isAdmin = await checkAdminStatus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Lostnfound(isAdmin: isAdmin)),
                      );
                    },
                  ),
                  ServiceBloc(
                    title: "Class Timetable",
                    description: "Your academic schedule",
                    icon: Icons.calendar_month_outlined,
                    onTap: () async{
                      bool isAdmin = await checkAdminStatus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TimeTable1(isAdmin: isAdmin)),
                      );
                    },
                  ),
                  ServiceBloc(
                    title: "Bus Routes",
                    description: "Transport schedules",
                    icon: Icons.directions_bus_outlined,
                    comingSoon: true,
                    // onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const ()),);
                    // },
                  ),
                  ServiceBloc(
                    title: "Landry",
                    description: "get notified when clothes are ready",
                    icon: Icons.local_laundry_service_outlined,
                    comingSoon: true,
                    // onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const ()),);
                    // },
                  ),
                  ServiceBloc(
                    title: "Complaints",
                    description: "Lodge complaints regarding campus issues",
                    icon: Icons.report_problem_outlined,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintPage()),);
                    },
                  ),
                  ServiceBloc(
                    title: "Quick Actions",
                    description: "Emergency contacts & services",
                    icon: Icons.notifications_outlined,
                    gradiant: true,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QuickActions()),);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Helper Widgets
  Widget _buildStatCard(String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCardWithIcon(
      String value, String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 25,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}