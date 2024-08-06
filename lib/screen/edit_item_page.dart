import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_it/global/style.dart';
import 'package:list_it/model/list_item.dart';
import 'package:provider/provider.dart';

import '../global/color.dart';
import '../model/category.dart';
import '../model/item.dart';
import '../provider/item_list_provider.dart';
import 'category_selection_page.dart';

class EditItemPage extends StatefulWidget {
  final int listIndex;
  final int? itemIndex;

  const EditItemPage({super.key, required this.listIndex, this.itemIndex});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  static const _pageTopColor = Color(0xFFF3CF8F);

  late final bool _editMode;
  late bool _buttonEnabled;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();


  late String _title;
  late Category _category;
  String? _note;
  double? _quantity;
  late QuantityUnit _quantityUnit;
  double? _price;


  @override
  void initState() {
    super.initState();
    if (widget.itemIndex == null) {
      _editMode = false;
      _buttonEnabled = false;
      _title = '';
      _category = Category.defaults[DefaultCategory.uncategorized]!; // TODO: FIX enum
      _note = null;
      _quantity = 0;
      _quantityUnit = QuantityUnit.none;
      _price = null;
    } else {
      _editMode = true;
      _buttonEnabled = true;
      ListItem item = Provider.of<ItemListProvider>(context, listen: false)
        .itemLists[widget.listIndex]
        .items[widget.itemIndex!];
      _title = item.title;
      _category = item.category;
      _note = item.note;
      _quantity = item.quantity;
      _quantityUnit = item.quantityUnit;
      _price = item.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editMode ? 'Edit item' : 'Add item'),
        backgroundColor: _pageTopColor,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    EdgeInsets padding = const EdgeInsets.only(top: 16, left: 16, right: 16);
    return ListView(
      children: [
        _itemNameField(),
        _categoryTile(),
        _noteField(padding: padding),
        _countRow(padding: padding),
        _quantityUnitSelector(padding: padding),
        _confirmButton(padding: padding),
      ],
    );
  }

  Widget _itemNameField() {
    return Container(
      color: _pageTopColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _titleController,
        onChanged: (value) => setState(() => _buttonEnabled = value.isNotEmpty),
        decoration: InputDecoration(
          hintText: 'Item name',
          hintStyle: const TextStyle(color: AppColors.grey_300),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _categoryTile() {
    return ListTile(
      tileColor: _pageTopColor,
      leading: const Icon(Icons.satellite, color: Colors.grey), // TODO: fix category icons
      title: Text(_category.title, style: TextStyle(color: Colors.grey[700])),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () async {
        final selectedCategory = await Navigator.push<Category>(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySelectionPage(
                initialCategory: _category
            ),
          ),
        );
        if (selectedCategory != null) {
          setState(() {
            _category = selectedCategory;
          });
        }
      },
    );
  }

  Widget _noteField({required EdgeInsets padding}) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: _noteController,
        initialValue: _note,
        decoration: AppStyles.defaultTextFieldDecoration(labelText: 'Note'),
        minLines: 3,
        maxLines: null,
      ),
    );
  }

  Widget _countRow({required EdgeInsets padding}) {
    return Container(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _qtyController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: AppStyles.defaultTextFieldDecoration(labelText: 'Quantity'),
              onChanged: (value) => setState(() {
                _quantity = value.isEmpty ? 0 : double.parse(value);
              }),
            ),
          ),

          const SizedBox(width: 8),

          _quantityButton( // increase button
            icon: Icons.add,
            onPressed: () => setState(() {
              _quantity = (_quantity ?? 0) + _getIncrement(_quantityUnit);
              _qtyController.text = _formatQuantity(_quantity, _quantityUnit);
            }),
          ),

          const SizedBox(width: 8),

          _quantityButton( // decrease button
            icon: Icons.remove,
            onPressed: () => setState(() {
              if (_qtyController.text.isEmpty) return;
              _quantity = max(0, double.parse(_qtyController.text) - _getIncrement(_quantityUnit));
              _qtyController.text = _formatQuantity(_quantity, _quantityUnit);
            }),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({required IconData icon, required VoidCallback onPressed}) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.grey),
        ),
      ),
    );
  }

  String _formatQuantity(double? quantity, QuantityUnit? unit) {
    if (quantity == null || quantity < 0.1) return '';
    if (unit == QuantityUnit.none || unit == QuantityUnit.g || unit == QuantityUnit.ml) {
      return quantity.toStringAsFixed(0);
    } else {
      return quantity.toString();
    }
  }

  double _getIncrement(QuantityUnit? unit) {
    switch (unit) {
      case QuantityUnit.none:
      case QuantityUnit.kg:
      case QuantityUnit.l:
        return 1.0;
      case QuantityUnit.g:
      case QuantityUnit.ml:
        return 100.0;
      default: return 1;
    }
  }

  Widget _quantityUnitSelector({required EdgeInsets padding}) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: QuantityUnit.values.map((unit) {
          return Expanded(
            child: CustomRadio(
              value: unit,
              groupValue: _quantityUnit,
              onChanged: (QuantityUnit value) {
                setState(() {
                  _quantityUnit = value;
                  _qtyController.text = _formatQuantity(_quantity, _quantityUnit);
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _confirmButton({required EdgeInsets padding}) {
    return Container(
      padding: padding,
      width: double.maxFinite,
      child: TextButton(
        style: _buttonEnabled ? AppStyles.defaultButtonStyle() : AppStyles.defaultDisabledButton,
        onPressed: _buttonEnabled ? _handleConfirm : null,
        child: Text(_editMode ? 'SAVE' : 'ADD'),
      ),
    );
  }

  void _handleConfirm() {
    if (!_buttonEnabled) return;

    ItemListProvider itemListProvider = Provider.of<ItemListProvider>(context, listen: false);

    final newItem = ListItem(
      id: DateTime.now().millisecondsSinceEpoch,
      item: Item(id: DateTime.now().millisecondsSinceEpoch, title: _titleController.text),
      title: _titleController.text,
      quantity: _quantity,
      category: _category,
      note: _noteController.text,
      checked: _editMode
        ? itemListProvider.itemLists[widget.listIndex].items[widget.itemIndex!].checked
        : false,
    );

    if (_editMode) { itemListProvider.updateItem(widget.listIndex, widget.itemIndex!, newItem); }
    else { itemListProvider.addItemToList(widget.listIndex, newItem); }
    Navigator.pop(context);
  }
}

class CustomRadio extends StatelessWidget {
  final QuantityUnit value;
  final QuantityUnit groupValue;
  final ValueChanged<QuantityUnit> onChanged;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.green_600 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.green_600 : AppColors.grey_400,
          ),
        ),
        child: Center(
          child: Text(
            value.name,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.grey_400,
            ),
          ),
        ),
      ),
    );
  }
}