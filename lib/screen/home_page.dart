import 'package:flutter/material.dart';
import 'package:list_it/screen/profile_page.dart';
import 'package:list_it/view/list_view.dart';

import '../global/color.dart';
import '../global/icon.dart';
import '../widget/ListCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ListViewPage(items: [
      ListCard(
        title: 'Grocery List',
        additionalInfo: '3 items',
        listSize: '2 days ago',
        imagePath: 'asset/svg/picture/list_card/groceries.svg',
        onTap: () => print('################ LIST CARD TAPPED'),
        onOptionsTap: () => print('################ LIST CARD OPTIONS TAPPED'),
      ),
      ListCard(
        title: 'Products',
        additionalInfo: 'Imported list',
        listSize: '0/8 items',
        imagePath: 'asset/svg/picture/list_card/products.svg',
        onTap: () => print('################ LIST CARD TAPPED'),
        onOptionsTap: () => print('################ LIST CARD OPTIONS TAPPED'),
      ),
    ]),
    ProfilePage(),
  ];

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
}



