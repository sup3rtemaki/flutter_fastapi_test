import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/components/grocery_list.dart';

import 'add_grocery_item_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {

    void _handleAddItem(){
      Navigator.of(context).pushNamed(AddGroceryItemScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddItem,
        child: Icon(
          Icons.add,
        ),
      ),
      body: GroceryList(
        handleAddItem: _handleAddItem
      ),
    );
  }
}
