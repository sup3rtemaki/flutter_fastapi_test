import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/providers/grocery_item_form_provider.dart';

import '../main.dart';

class AddGroceryItemScreen extends StatefulWidget {
  static const routeName = '/add-grocery-item';

  const AddGroceryItemScreen({Key? key}) : super(key: key);

  @override
  _AddGroceryItemScreenState createState() => _AddGroceryItemScreenState();
}

class _AddGroceryItemScreenState extends State<AddGroceryItemScreen> {
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

  final formProvider = getIt<GroceryItemFormProvider>();

  void _handleSave() async {
    if (formProvider.isProcessing) {
      return;
    }

    final newItem = await formProvider.saveItem();
    if (newItem != null) {
      print(newItem.name);
    } else {
      //TODO Show error
    }
  }

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
