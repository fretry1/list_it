import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global/color.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String additionalInfo;
  final int itemCount;
  final String imagePath;
  final VoidCallback onTap;
  final VoidCallback onOptionsTap;

  const ListCard({
    super.key,
    required this.title,
    required this.additionalInfo,
    required this.itemCount,
    required this.imagePath,
    required this.onTap,
    required this.onOptionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64+32,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: _boxDecoration(),
        child: Row(
          children: [
            _imageSection(imagePath),
            _componentSection(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  ClipRRect _imageSection(String imagePath) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      child: Stack(
        children: [
          const SizedBox(
            width: 64+32,
            height: 64+32,
          ),
          Positioned(
            top: 10,
            left: -13,
            child: SvgPicture.asset(imagePath, height: 64+32),
          ),
        ],
      ),
    );
  }

  Widget _componentSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topRow(),
            const Spacer(),
            _bottomRow(),
          ],
        ),
      ),
    );
  }

  Widget _topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        GestureDetector(
          onTap: onOptionsTap,
          child: const Icon(Icons.more_vert, size: 20, color: AppColors.grey_600),
        ),
      ],
    );
  }

  Widget _bottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          additionalInfo,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          itemCount.toString(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
