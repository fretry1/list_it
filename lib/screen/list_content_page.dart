import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global/color.dart';
import '../global/icon.dart';

class ListContentPage extends StatelessWidget {
  final String title;

  const ListContentPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          // Example items
          _CategoryDelimiterTile(categoryName: 'Fruits & Vegetables'),
          _ItemTile(
            title: 'Apple',
            count: '2',
            onIconPressed: () { }
          ),
          _ItemTile(
              title: 'Banana',
              count: '1',
              onIconPressed: () { }
          ),
          _ItemTile(
              title: 'Kiwi',
              count: '2',
              onIconPressed: () { }
          ),
        ],
      )
    );
  }
}

class _CategoryDelimiterTile extends StatelessWidget {
  final String categoryName;
  final Color color = AppColors.green_600;

  const _CategoryDelimiterTile({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        color: color,
        child: Text(
          categoryName,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontVariations: [FontVariation('wght', 350)]
          )
        ),
      ),
    );
  }
}

class _ItemTile extends StatefulWidget {
  final String title;
  final String count;
  final VoidCallback onIconPressed;

  const _ItemTile({
    required this.title,
    required this.count,
    required this.onIconPressed,
  });

  @override
  State<_ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<_ItemTile> {
  bool _isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _listTile([
        _checkbox(_isChecked, 24),
        _title(),
        const SizedBox(width: 8),
        _count(),
        const SizedBox(width: 8),
        _iconButton(),
      ]
    );
  }

  Widget _listTile(List<Widget> children) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: children
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Expanded(
      child: Text(
        widget.title,
        style: TextStyle(
          decoration: _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
    );
  }

  Widget _checkbox(bool isChecked, double size) {
    SvgPicture icon = isChecked
      ? AppIcons.checkboxChecked.preColoredIcon(size)
      : AppIcons.checkboxUnchecked.preColoredIcon(size);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: icon,
    );
  }

  Widget _count() {
    return Text(
      'Count: ${widget.count}',
      style: TextStyle(
        decoration: _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  Widget _iconButton() {
    return IconButton(
      icon: const Icon(Icons.chevron_right, color: AppColors.grey_400),
      onPressed: widget.onIconPressed,
    );
  }
}