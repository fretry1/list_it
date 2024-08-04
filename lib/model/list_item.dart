import 'category.dart';
import 'item.dart';

class ListItem {
  final int id;
  final Item item;
  final String title;
  Category category; // default to Category
  String note;
  double quantity;
  QuantityUnit quantityUnit;
  double price;
  bool checked;

  ListItem({
    required this.id,
    required this.item,
    required this.title,
    Category? category,
    String? note,
    double? quantity,
    QuantityUnit? unit,
    double? price,
    bool? checked,
  }) :
        category = category ?? Category.defaults.values.first,
        note = note ?? '',
        quantity = quantity ?? 0,
        quantityUnit = unit ?? QuantityUnit.none,
        price = price ?? 0.0,
        checked = checked ?? false;

  void check() {
    checked = !checked;
  }

}

enum QuantityUnit {
  none,
  kg,
  g,
  l,
  ml;
}

