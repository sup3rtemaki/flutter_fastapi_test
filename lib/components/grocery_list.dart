import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';
import 'package:flutter_fastapi_test/providers/grocery_list_provider.dart';
import 'package:flutter_fastapi_test/services/grocery_item_service.dart';
import 'package:flutter_fastapi_test/theme.dart';

import '../main.dart';
import 'empty_list_indicator.dart';
import 'grocery_item_card.dart';

class GroceryList extends StatefulWidget {

  final Function handleAddItem;
  const GroceryList({Key? key, required this.handleAddItem}) : super(key: key);

  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

  final listProvider = getIt<GroceryListProvider>();

  @override
  void initState() {
    super.initState();

    listProvider.addListener(() {
      setStateIfMounted(() {});
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future<void> _refreshData() async {
    //_loadData();
  }

  @override
  Widget build(BuildContext context) {

    final items = listProvider.items;

    if(!listProvider.ready){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(items.length == 0){
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
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            final temp = listProvider.groupedItems;
            final item = items[index];
            return GroceryitemCard(groceryItem: item);
          }
      ),
    );
  }
}