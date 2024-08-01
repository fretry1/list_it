import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global/color.dart';
import '../widget/ListCard.dart';

class ListViewPage extends StatelessWidget {
  final List<ListCard> items;

  const ListViewPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return _noListsYetView();

    return Container(
      color: AppColors.grey_25,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }

  Widget _noListsYetView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _happyOrange(256, 256),
          const SizedBox(height: 16),
          const Text(
            'You have no lists yet...',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  SvgPicture _happyOrange(double width, double height) {
    return SvgPicture.asset('asset/svg/picture/happy_orange.svg', width: width, height: height);
  }
}