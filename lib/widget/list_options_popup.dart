import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:list_it/widget/rename_list_popup.dart';
import 'package:provider/provider.dart';

import '../global/color.dart';
import '../provider/item_list_provider.dart';

class ListOptionsPopup extends StatefulWidget {
  final ItemListProvider itemListProvider;
  final int listIndex;

  const ListOptionsPopup({super.key, required this.itemListProvider, required this.listIndex});

  @override
  ListOptionsPopupState createState() => ListOptionsPopupState();
}

class ListOptionsPopupState extends State<ListOptionsPopup> {
  final _textCtrl = TextEditingController();


  @override
  void initState() {
    super.initState();
    _textCtrl.text = widget.itemListProvider.itemLists[widget.listIndex].title;
  }

  @override
  Widget build(BuildContext context) {
    return _popupWindow(
      context: context,
      content: Container(

        margin: const EdgeInsets.all(12),
        width: double.maxFinite,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textLabel(),
            _button(icon: Icons.edit, text: 'Rename', onTap: () => _showRenamePopup(context, widget.itemListProvider, widget.listIndex)),
            _button(icon: Icons.share, text: 'Share', onTap: () => { }),
            _button(icon: Icons.add_to_photos_rounded, text: 'Duplicate', onTap: () => { }),
            _button(icon: Icons.delete_rounded, text: 'Delete', onTap: () => { }),
          ],
        ),
      ),
    );
  }

  Widget _popupWindow({required BuildContext context, required Widget content}) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            content,
            // Close button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close_rounded, color: AppColors.grey_900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textLabel() {
    return const Text(
      'List Options',
      style: TextStyle(
        fontSize: 20,
        fontVariations: [FontVariation('wght', 500)],
      ),
    );
  }

  Widget _button({required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.grey_900,),
            const SizedBox(width: 16),
            Text(text),
          ],
        )
      ),
    );
  }
  
  void _showRenamePopup(BuildContext context, ItemListProvider itemListProvider, int listIndex) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      barrierDismissible: true,
        builder: (BuildContext context) {
          return RenameListPopup(
            listIndex: listIndex,
            itemListProvider: itemListProvider,
          );
        }
    );
  }
}