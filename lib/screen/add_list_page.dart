import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _addItemList(context);
                  }
                },
                child: Text('Add List'),
              ),
            ],
          ),
        ),
      ),
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
}
