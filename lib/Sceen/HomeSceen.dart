import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'SettingSceen.dart';




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              padding: const EdgeInsets.all(16),
              tabs:[
                GButton(icon: Icons.home,text: "หน้าหลัก",),
                GButton(icon: Icons.add, text: "เพิ่มเนื้อหา"),
                GButton(icon: Icons.notifications_none, text: "แจ้งเตือน"),
                GButton(icon: Icons.settings, text: "ตั้งค่า",onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const SettingSceen()));
                },),
              ],
            ),
          ),
        ),
    );
  }
}
