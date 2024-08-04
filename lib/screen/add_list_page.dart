import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/color.dart';
import '../model/item_list.dart';
import '../provider/item_list_provider.dart';

class AddListPage extends StatefulWidget {
  @override
  _AddListPageState createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  bool _buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new list'),
      ),
      body: _body(),
    );
  }

  void _addItemList(BuildContext context) {
    final newItemList = ItemList(
      DateTime.now().millisecondsSinceEpoch,
      _title,
      _description,
      [],
    );

    Provider.of<ItemListProvider>(context, listen: false).addItemList(newItemList);
    Navigator.pop(context);
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _titleField(),
            const SizedBox(height: 12),
            _noteField(),
            const SizedBox(height: 12),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  InputDecoration _textFieldDecoration({required String title}) {
    return InputDecoration(
      labelText: title,
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: Colors.grey[600]),
      floatingLabelStyle: const TextStyle(color: AppColors.green_600),
      filled: true,
      fillColor: Colors.grey[200],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.green_600),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red_600),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red_600),
      ),
      isDense: true,
    );
  }

  TextFormField _titleField() {
    return TextFormField(
      decoration: _textFieldDecoration(title: 'Title'),
      autofocus: true,
      onChanged: (value) {
        setState(() {
          _buttonEnabled = value.isNotEmpty;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
      onSaved: (value) {
        _title = value!;
      },
    );
  }

  TextFormField _noteField() {
    return TextFormField(
      decoration: _textFieldDecoration(title: 'Note'),
      minLines: 3,
      maxLines: 9,
      onSaved: (value) {
        _description = value!;
      },
    );
  }

  Widget _confirmButton() {
    return SizedBox(
      width: double.maxFinite,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.green_600,
          disabledBackgroundColor: AppColors.grey_200,
          disabledForegroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: _buttonEnabled
        ? () {
          _formKey.currentState!.save();
          _addItemList(context);
        } : null,
        child: const Text('ADD LIST'),
      ),
    );
  }
}
