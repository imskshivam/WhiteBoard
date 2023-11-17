import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_room_screen.dart';
import 'package:flutter_application_1/join_room_screen.dart';
import 'package:flutter_application_1/screens/Events.dart';

import 'package:flutter_application_1/screens/homeScreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 0;

  List<Widget> _pages = [
    const Homescreen(),
    const Center(
      child: Text("add page"),
    ),
    const Center(
      child: JoinRoomScreen(),
    ),
    const Center(child: CreateRoomScreen()),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: GNav(
          onTabChange: (value) {
            print(value);
            setState(() {
              _page = value;
            });
          },
          color: Colors.grey,
          activeColor: Colors.green,
          backgroundColor: Colors.transparent,
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.qr_code_scanner,
              text: 'Scan',
            ),
            GButton(
              icon: Icons.event_available,
              text: 'Events',
            ),
            GButton(
              icon: Icons.add,
              text: 'Create',
            )
          ]),
    );
  }
}
