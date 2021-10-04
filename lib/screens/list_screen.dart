import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/components/grocery_list.dart';
import 'package:flutter_fastapi_test/providers/grocery_item_form_provider.dart';
import 'package:flutter_fastapi_test/providers/grocery_list_provider.dart';

import '../main.dart';
import 'add_grocery_item_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  final listProvider = getIt<GroceryListProvider>();

  bool hidePurchased = false;

  void _handleAddItem() {
    getIt<GroceryItemFormProvider>().clearItem();
    Navigator.of(context).pushNamed(AddGroceryItemScreen.routeName);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                hidePurchased = !hidePurchased;
              });
            },
            icon: Icon(hidePurchased ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddItem,
        child: Icon(
          Icons.add,
        ),
      ),
      body: GroceryList(
        handleAddItem: _handleAddItem,
        hidePurchased: hidePurchased,
      ),
    );
  }
}
