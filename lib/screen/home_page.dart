import 'package:flutter/material.dart';
import 'package:list_it/screen/profile_page.dart';
import 'package:list_it/screen/list_page.dart';

import '../global/color.dart';
import '../global/icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My lists'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBar _bottomBar() {
    Color select = AppColors.green_600;
    Color unselect = AppColors.grey_600;
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 16,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: AppIcons.home.icon(16, _selectedIndex==0 ? select : unselect),
        ), label: 'Home'),
        BottomNavigationBarItem(icon: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: AppIcons.profile.icon(20, _selectedIndex==1 ? select : unselect),
        ), label: 'Profile'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  static List<Widget> get _widgetOptions => [
    ListPage(),
    ProfilePage(),
  ];
}