import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';

class GroceryItemCheckbox extends StatefulWidget {

  final GroceryItem groceryItem;
  final Function onUpdate;

  const GroceryItemCheckbox({Key? key, required this.groceryItem, required this.onUpdate}) : super(key: key);

  @override
  _GroceryItemCheckboxState createState() => _GroceryItemCheckboxState();
}

class _GroceryItemCheckboxState extends State<GroceryItemCheckbox> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        widget.groceryItem.purchased = !widget.groceryItem.purchased;
        setState(() {});
        widget.onUpdate();
      },
      icon: Icon(
          widget.groceryItem.purchased ? Icons.check_box_outlined : Icons.check_box_outline_blank
      ),
    );
  }
}
