import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';
import 'package:flutter_fastapi_test/services/grocery_item_service.dart';
import 'package:flutter_fastapi_test/theme.dart';

import 'empty_list_indicator.dart';
import 'grocery_item_card.dart';

class GroceryList extends StatefulWidget {

  final Function handleAddItem;
  const GroceryList({Key? key, required this.handleAddItem}) : super(key: key);

  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

  List<GroceryItem> _items = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
    });
    final items = await groceryItemService.list();
    setState(() {
      _items = items;
      _loading = false;
    });
  }

  Future<void> _refreshData() async {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {

    if(_loading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_items.length == 0){
      return Center(
        child: EmptyListIndicator(
          title: "No Grocery items",
          buttonText: "Add",
          onButtonPressed: widget.handleAddItem,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (ctx, index) {
            final item = _items[index];
            return GroceryitemCard(groceryItem: item);
          }
      ),
    );
  }
}