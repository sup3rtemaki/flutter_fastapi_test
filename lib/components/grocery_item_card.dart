import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/components/grocery_item_checkbox.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';
import 'package:flutter_fastapi_test/theme.dart';

class GroceryitemCard extends StatelessWidget {

  final GroceryItem groceryItem;

  const GroceryitemCard({Key? key, required this.groceryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    groceryItem.name,
                    style: ThemeText.bodyText,
                  ),
                  Text(
                    groceryItem.categoryLabel,
                    style: ThemeText.caption,
                  )
                ],
              ),
              GroceryItemCheckbox(groceryItem: groceryItem),
            ],
          ),
        )
    );
  }
}
