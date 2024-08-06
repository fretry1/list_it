import 'list_item.dart';

class ItemList {
  final int id;
  late String _title;
  final String description;
  final List<ListItem> items;

  ItemList(this.id, String title, this.description, this.items) {
    _title = title;
  }

  String get title => _title;

  set title(String title) {
    title = title.trim();
    if (title.isEmpty || !RegExp(r'^[a-zA-Z0-9\s]*$').hasMatch(title)) {
      throw ArgumentError("Title must consist of only alphanumeric and whitespace characters.");
    }
    _title = title;
  }

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