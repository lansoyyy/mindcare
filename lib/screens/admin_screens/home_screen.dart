import 'package:flutter/material.dart';
import 'package:medzone/screens/admin_screens/home_tab.dart';
import 'package:medzone/screens/admin_screens/nurse_tab.dart';
import 'package:medzone/screens/admin_screens/patients_tab.dart';
import 'package:medzone/screens/admin_screens/profile_tab.dart';

import '../../utils/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> children = [
    const AdminDashboardTab(),
    const AdminPatientsTab(),
    const AdminNurseTab(),
    const AdminProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: 'Bold'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Bold'),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Patients'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_sharp), label: 'Nurse'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
      ),
    );
  }
}
