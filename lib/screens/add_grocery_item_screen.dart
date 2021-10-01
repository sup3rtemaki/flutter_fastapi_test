import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';
import 'package:flutter_fastapi_test/providers/grocery_item_form_provider.dart';
import 'package:flutter_fastapi_test/providers/grocery_list_provider.dart';
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
      getIt<GroceryListProvider>().addItem(newItem);
      Navigator.of(context).pop();
    } else {
      //TODO Show error
      print("Error");
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
        'label': GroceryItem.stringFromCategory(category),
      };
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add item",
        ),
        actions: [
          formProvider.isProcessing
              ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          )
              : TextButton(
            onPressed: _handleSave,
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
          child: Column(
              children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Item Name"),
                autofocus: true,
                onChanged: (value) {
                  formProvider.setName(value);
                },
                validator: formProvider.validateName,
              ),
              SelectFormField(
                type: SelectFormFieldType.dropdown,
                // or can be dialog
                initialValue: 'misc',
                //icon: Icon(Icons.local_offer),
                labelText: 'Category',
                items: _categories,
                onChanged: (val) {
                  formProvider.setCategory(GroceryItem.categoryFromString(val));
                },
                onSaved: (val) => print(val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}