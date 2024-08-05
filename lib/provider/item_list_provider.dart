import 'package:flutter/cupertino.dart';
import 'package:list_it/model/item.dart';

import '../model/category.dart';
import '../model/item_list.dart';
import '../model/list_item.dart';

class ItemListProvider with ChangeNotifier {
  List<ItemList> _itemLists = _generateExampleLists();

  List<ItemList> get itemLists => _itemLists;

  void addItemList(ItemList itemList) {
    _itemLists.add(itemList);
    notifyListeners();
  }

  void deleteItemList(int listIndex) {
    _itemLists.removeAt(listIndex);
    notifyListeners();
  }

  void addItemToList(int listIndex, ListItem item) {
    _itemLists[listIndex].items.add(item);
    notifyListeners();
  }
  
  void reorderItemLists(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ItemList list = _itemLists.removeAt(oldIndex);
    _itemLists.insert(newIndex, list);
    notifyListeners();
  }
  
  void updateItem(int listIndex, int itemIndex, ListItem updatedItem) {
    _itemLists[listIndex].items[itemIndex] = updatedItem;
    notifyListeners();
  }
  
  void deleteItem(int listIndex, int itemIndex) {
    _itemLists[listIndex].removeItemAt(itemIndex);
    notifyListeners();
  }

  void markItemAsChecked(int listIndex, int itemIndex) {
    _itemLists[listIndex].items[itemIndex].check();
    notifyListeners();
  }
  
  

  static List<ItemList> _generateExampleLists() {
    // Items for first test list
    Item item1 = Item(id: 0, title: 'apples');
    Item item2 = Item(id: 1, title: 'bananas');
    Item item3 = Item(id: 3, title: 'milk');

    // ListItems for first test list
    List<ListItem> listItems1 = [
      ListItem(id: item1.id, item: item1, title: item1.title, category: Category.defaults[DefaultCategory.fruitsAndVegetables]),
      ListItem(id: item2.id, item: item2, title: item2.title, category: Category.defaults[DefaultCategory.fruitsAndVegetables]),
      ListItem(id: item3.id, item: item3, title: item3.title, category: Category.defaults[DefaultCategory.dairyAndEggs])
    ];

    Item item4 = Item(id: 4, title: 'frozen chicken');
    Item item5 = Item(id: 5, title: 'frozen raspberries');
    Item item6 = Item(id: 6, title: 'hand soap');

    List<ListItem> listItems2 = [
      ListItem(id: item4.id, item: item4, title: item4.title, category: Category.defaults[DefaultCategory.frozen]),
      ListItem(id: item5.id, item: item5, title: item5.title, category: Category.defaults[DefaultCategory.frozen]),
      ListItem(id: item6.id, item: item6, title: item6.title, category: Category.defaults[DefaultCategory.hygiene])
    ];

    return [
      ItemList(
        0,
        "Test list 1",
        "Description A",
        listItems1
      ),
      ItemList(
          1,
          "Test list 2",
          "Description B",
          listItems2
      ),
    ];
  }

  void removeCheckedItems(int listIndex) {
    itemLists[listIndex].removeCheckedItems();
    notifyListeners();
  }
}