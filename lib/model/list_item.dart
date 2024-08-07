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
    QuantityUnit? quantityUnit,
    double? price,
    bool? checked,
  }) :
        category = category ?? Category.defaults.values.first,
        note = note ?? '',
        quantity = quantity ?? 0,
        quantityUnit = quantityUnit ?? QuantityUnit.none,
        price = price ?? 0.0,
        checked = checked ?? false;

  void check() {
    checked = !checked;
  }

  /// Get the quantity formatted based on quantity unit
  String fmtQty() {
    switch (quantityUnit) {
      case QuantityUnit.none: return quantity.toStringAsFixed(0);
      case QuantityUnit.kg:   return '${quantity.toStringAsFixed(1)} ${quantityUnit.name}';
      case QuantityUnit.g:    return '${quantity.toStringAsFixed(0)} ${quantityUnit.name}';
      case QuantityUnit.l:    return '${quantity.toStringAsFixed(1)} ${quantityUnit.name}';
      case QuantityUnit.ml:    return '${quantity.toStringAsFixed(0)} ${quantityUnit.name}';
    }
  }

}

enum QuantityUnit {
  none,
  kg,
  g,
  l,
  ml;
}

