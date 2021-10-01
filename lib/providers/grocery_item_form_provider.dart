import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';

abstract class GroceryItemFormProvider extends ChangeNotifier {
  GroceryItem _groceryItem = GroceryItem();
  bool _isProcessing = false;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  //Getters
  GroceryItem get groceryItem;
  bool get isProcessing;
  GlobalKey<FormState> get form;

  //Operations
  void clearItem();
  loadItem(GroceryItem item);
  Future<GroceryItem?> saveItem();

  //Validation
  String? validateName(String? value);

  //Values
  void setName(String name);
}

class GroceryItemFormProviderImplementation extends GroceryItemFormProvider {
  // GroceryItemFormProviderImplementation() {}

  void handleUpdate() {
    this.notifyListeners();
  }

  @override
  void clearItem() {
    this._groceryItem = GroceryItem();
    this.handleUpdate();
  }

  @override
  GlobalKey<FormState> get form => _form;

  @override
  GroceryItem get groceryItem => _groceryItem;

  @override
  bool get isProcessing => _isProcessing;

  @override
  loadItem(GroceryItem item) {
    this._groceryItem = item;
    this.handleUpdate();
  }

  @override
  Future<GroceryItem?> saveItem() async {
    if(!_form.currentState!.validate()){
      this.handleUpdate();
      return null;
    }
    _isProcessing = true;
    this.handleUpdate();
    await Future.delayed(const Duration(milliseconds: 500));
    final newGroceryItem = GroceryItem.fromJson({
      'id': 99,
      'name': this._groceryItem.name,
      'category': 'misc',
      'is_purchased': false
    });
    _isProcessing = false;
    this.handleUpdate();
    return newGroceryItem;
  }

  @override
  String? validateName(String? value) {
    if(value == null || value.isEmpty){
      return "Item name is required";
    }
    return null;
  }

  @override
  void setName(String name) {
    this._groceryItem.name = name;
    this.handleUpdate();
  }
}