import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';
import 'package:flutter_fastapi_test/providers/grocery_item_form_provider.dart';
import 'package:flutter_fastapi_test/providers/grocery_list_provider.dart';
import 'package:flutter_fastapi_test/services/toast_service.dart';
import 'package:select_form_field/select_form_field.dart';

import '../main.dart';

class AddGroceryItemScreen extends StatefulWidget {
  static const routeName = '/add-grocery-item';

  const AddGroceryItemScreen({Key? key}) : super(key: key);

  @override
  _AddGroceryItemScreenState createState() => _AddGroceryItemScreenState();
}

class _AddGroceryItemScreenState extends State<AddGroceryItemScreen> {

  final formProvider = getIt<GroceryItemFormProvider>();

  @override
  void initState() {
    super.initState();

    formProvider.addListener(() {
      setStateIfMounted(() {});
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void _handleSave() async {
    if (formProvider.isProcessing) {
      return;
    }

    final newItem = await formProvider.saveItem();

    if (newItem != null) {
      Navigator.of(context).pop();
    } else {
      ToastService.error("A problem occurred");
    }
  }

  @override
  Widget build(BuildContext context) {

    final categories = [
      Category.Produce,
      Category.Bakery,
      Category.Dairy,
      Category.Frozen,
      Category.Aisle,
      Category.Household,
      Category.Misc
    ];

    final List<Map<String, dynamic>> _categories = categories.map((category) {
      return {
        'value': GroceryItem.stringFromCategory(category),
        'label': GroceryItem.stringFromCategory(category)!.toUpperCase(),
      };
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add item",
        ),
        actions: [
          TextButton(
            onPressed: formProvider.isProcessing ? null : _handleSave,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Form(
        key: formProvider.form,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                  children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Item Name"),
                    autofocus: true,
                    initialValue: formProvider.groceryItem.name,
                    onChanged: (value) {
                      formProvider.setName(value);
                    },
                    validator: formProvider.validateName,
                  ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    initialValue: formProvider.groceryItem.categoryValue,
                    labelText: 'Category',
                    items: _categories,
                    onChanged: (val) {
                      formProvider.setCategory(
                          GroceryItem.categoryFromString(val)
                      );
                    },
                    onSaved: (val) => print(val),
                  ),
                ],
              ),
              if(formProvider.isProcessing)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}