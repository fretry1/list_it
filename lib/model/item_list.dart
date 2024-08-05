import 'list_item.dart';

class ItemList {
  final int id;
  final String title;
  final String description;
  final List<ListItem> items;

  ItemList(this.id, this.title, this.description, this.items);

  void addItem(ListItem item) {
    items.add(item);
  }

  void removeItemAt(int itemIdx) {
    if (itemIdx < 0 || itemIdx >= items.length) {
      throw IndexError.withLength(itemIdx, items.length);
    }
    items.removeAt(itemIdx);
  }

  void replaceItemAt(int itemIdx, ListItem item) {
    if (itemIdx < 0 || itemIdx >= items.length) {
      throw IndexError.withLength(itemIdx, items.length);
    }
    items[itemIdx] = item;
  }

  void removeCheckedItems() {
    items.removeWhere((item) => item.checked);
  }
}