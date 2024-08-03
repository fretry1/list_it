import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../global/color.dart';
import '../global/icon.dart';
import '../model/category.dart';
import '../model/item_list.dart';
import '../model/list_item.dart';
import '../provider/item_list_provider.dart';

class ListContentPage extends StatelessWidget {
  final int listIndex;

  const ListContentPage({super.key, required this.listIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemListProvider>(
      builder: (context, itemListProvider, child) {

        final ItemList itemList = itemListProvider.itemLists[listIndex];
        final Map<Category, List<ListItem>> groupedItems = _groupItemsByCategory(itemList);

        return Scaffold(
          appBar: AppBar(
            title: Text(itemList.title),
          ),
          body: _listViewBuilder(groupedItems, itemListProvider, itemList),
        );
      },
    );
  }

  ListView _listViewBuilder(Map<Category, List<ListItem>> groupedItems, ItemListProvider itemListProvider, ItemList itemList) {
    return ListView.builder(
      itemCount: groupedItems.keys.length,
      itemBuilder: (context, categoryIndex) {
        final category = groupedItems.keys.elementAt(categoryIndex);
        final List<ListItem> items = groupedItems[category]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryDelimiterTile(categoryName: category.title),
              ...items.map((item) => _ItemTile(
                item: item,
                onTap: () => itemListProvider.markItemAsChecked(listIndex, itemList.items.indexOf(item)),
                onIconTap: () { /* TODO: implement */ },
              ),
            ),
          ],
        );
      }
    );
  }

  Map<Category, List<ListItem>> _groupItemsByCategory(ItemList itemList) {
    final Map<Category, List<ListItem>> groupedItems = {};
    for (ListItem item in itemList.items) {
      groupedItems.putIfAbsent(item.category, () => []).add(item);
    }
    return groupedItems;
  }


}

class _CategoryDelimiterTile extends StatelessWidget {
  final String categoryName;
  final Color color = AppColors.green_600;

  const _CategoryDelimiterTile({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Material(
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
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  final ListItem item;
  final VoidCallback onTap;
  final VoidCallback onIconTap;

  _ItemTile({
    required this.item,
    required this.onTap,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return _listTile([
      _checkbox(size: 24),
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
      onTap: onTap,
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
        item.title,
        style: TextStyle(
          decoration: item.checked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
    );
  }

  Widget _checkbox({required double size}) {
    SvgPicture icon = item.checked
        ? AppIcons.checkboxChecked.preColoredIcon(size)
        : AppIcons.checkboxUnchecked.preColoredIcon(size);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: icon,
    );
  }

  Widget _count() {
    return Text(
      '${item.quantity.toInt()}',
      style: TextStyle(
        decoration: item.checked ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  Widget _iconButton() {
    return IconButton(
      icon: const Icon(Icons.chevron_right, color: AppColors.grey_400),
      onPressed: onIconTap,
    );
  }
}