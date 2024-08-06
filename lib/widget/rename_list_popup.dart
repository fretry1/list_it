import 'package:flutter/material.dart';

import '../global/color.dart';
import '../global/style.dart';
import '../provider/item_list_provider.dart';

class RenameListPopup extends StatelessWidget {
  final _textCtrl = TextEditingController();
  final ItemListProvider itemListProvider;
  final int listIndex;

  RenameListPopup({super.key, required this.itemListProvider, required this.listIndex}) {
    _textCtrl.text = itemListProvider.itemLists[listIndex].title;
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: _content(context, itemListProvider, listIndex),
      ),
    );
  }

  Widget _content(BuildContext context, ItemListProvider ilp, int listIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _textLabel(),
        const SizedBox(height: 8),
        _textField(),
        const SizedBox(height: 16),
        _buttons(context, ilp, listIndex),
      ],
    );
  }

  Widget _textLabel() {
    return const Text(
      'Rename List',
      style: TextStyle(
        fontSize: 20,
        fontVariations: [FontVariation('wght', 500)],
      ),
    );
  }

  Widget _textField() {
    return Material(
      child: TextField(
        autofocus: true,
        controller: _textCtrl,
      ),
    );
  }

  Widget _buttons(BuildContext context, ItemListProvider itemListProvider, int listIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: const Text('Cancel'),
          style: AppStyles.defaultButtonStyle(backgroundColor: AppColors.red_600),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 8),
        TextButton(
          child: const Text('Save'),
          style: AppStyles.defaultButtonStyle(backgroundColor: AppColors.green_600),
          onPressed: ()  {
            itemListProvider.renameItemList(listIndex, _textCtrl.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
  
}