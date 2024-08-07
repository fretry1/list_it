import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:list_it/global/style.dart';
import 'package:provider/provider.dart';

import '../global/color.dart';
import '../global/icon.dart';
import '../model/category.dart';
import '../model/item_list.dart';
import '../model/list_item.dart';
import '../provider/item_list_provider.dart';
import 'edit_item_page.dart';

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
          backgroundColor: AppColors.grey_75,
          appBar: AppBar(
            title: Text(itemList.title),
          ),
          body: Stack(
            children: [
              _listViewBuilder(groupedItems, itemListProvider, itemList),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: _floatingActionBar(context, itemListProvider),
              ),
            ],
          ),
        );
      },
    );
  }

  Container _listViewBuilder(Map<Category, List<ListItem>> groupedItems, ItemListProvider itemListProvider, ItemList itemList) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: ListView.builder(
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
                  onEditTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditItemPage(listIndex: listIndex, itemIndex: itemList.items.indexOf(item)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        }
      ),
    );
  }

  Map<Category, List<ListItem>> _groupItemsByCategory(ItemList itemList) {
    final Map<Category, List<ListItem>> groupedItems = {};
    for (ListItem item in itemList.items) {
      groupedItems.putIfAbsent(item.category, () => []).add(item);
    }
    return groupedItems;
  }

  Widget _floatingActionBar(BuildContext context, ItemListProvider itemListProvider) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: AppStyles.defaultMaterialButton(
              text: 'CLEAR CHECKED',
              onPressed: () => itemListProvider.removeCheckedItems(listIndex),
              backgroundColor: AppColors.orange_600,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 48,
            child: AppStyles.defaultMaterialButton(
              text: 'ADD ITEM',
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditItemPage(listIndex: listIndex))),
            ),
          ),
        ),
      ],
    );
  }


}

class _CategoryDelimiterTile extends StatelessWidget {
  final String categoryName;
  final Color color = AppColors.green_600;

  const _CategoryDelimiterTile({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return _tile([
      const Icon(Icons.image, color: AppColors.green_600),
      const SizedBox(width: 12),
      Text(categoryName),
    ]);
  }

  Widget _tile(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      height: 32,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Row(
        children: children,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  final ListItem item;
  final VoidCallback onTap;
  final VoidCallback onEditTap;

  const _ItemTile({
    required this.item,
    required this.onTap,
    required this.onEditTap,

  });

  @override
  Widget build(BuildContext context) {
    return _listTile([
      _checkbox(size: 32),
      _title(),
      const SizedBox(width: 8),

      if (item.quantity != 0) _count(),
      if (item.quantity != 0) const SizedBox(width: 8),

      _iconButton(),
      const SizedBox(width: 8),
    ]);
  }

  Widget _listTile(List<Widget> children) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 48,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Row(children: children),
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
    return GestureDetector(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 36,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.grey_75, borderRadius: BorderRadius.circular(8)),
          child: Text(
            item.fmtQty(),
            style: TextStyle(
              decoration: item.checked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton() {
    return GestureDetector(
      onTap: onEditTap,
      child: Container(
        decoration: BoxDecoration(color: AppColors.grey_75, borderRadius: BorderRadius.circular(8)),
        width: 36,
        height: 36,
        child: const Icon(
          Icons.more_vert,
          color: AppColors.grey_400,
          size: 20,
        )
      ),
    );
  }
}