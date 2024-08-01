import 'package:flutter/material.dart';

import '../view/list_content_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[200],
      child: MaterialButton(
        child: Text('View Item List'),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ListContentPage(title: 'Grocery List'))),
      ),
    );
  }

}