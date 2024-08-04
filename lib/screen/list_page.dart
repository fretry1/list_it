import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../global/color.dart';
import '../model/item_list.dart';
import '../provider/item_list_provider.dart';
import '../widget/list_card.dart';
import 'add_list_page.dart';
import 'list_content_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ItemListProvider>(
        builder: (context, itemListProvider, child) {
          final List<ItemList> lists = itemListProvider.itemLists;
          if (lists.isEmpty) return _noListsYetView();
          return _listView(context, lists, itemListProvider);
        },
      ),
      floatingActionButton: _addListButton(context),
    );
  }

  Widget _listView(BuildContext context, List<ItemList> lists, ItemListProvider itemListProvider) {
    return Container(
      color: AppColors.grey_25,
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        onReorder: (int oldIndex, int newIndex) {
          itemListProvider.reorderItemLists(oldIndex, newIndex);
        },
        children: List.generate(
          lists.length,
          (index) => _listCard(context, lists[index], index, key: ValueKey(lists[index].id),
          ),
        ),

        // Removes background from ListCard that's being moves
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Material(
            elevation: 20,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: child,
          );
        },
      ),
    );
  }

  ListCard _listCard(BuildContext context, ItemList list, int listIndex, {required Key key}) {
    return ListCard(
      key: key,
      title: list.title,
      additionalInfo: list.description,
      itemCount: list.items.length,
      imagePath: 'asset/svg/picture/list_card/groceries.svg',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListContentPage(
              listIndex: listIndex,
            ),
          ),
        );
      },
      onOptionsTap: () {
        // TODO: implement options
      },
    );
  }

  // _showListContent(BuildContext context,

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

  FloatingActionButton _addListButton(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.green_600,
      label: const Text('ADD LIST'),
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddListPage(),
          ),
        );
      },
    );
  }
}