import 'package:flutter/cupertino.dart';
import 'package:flutter_fastapi_test/mocks/grocery_items_mock.dart';
import 'package:flutter_fastapi_test/models/grocery_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroceryItemService{

  Future<List<GroceryItem>> list() async {

    final data = groceryItems;
    await Future.delayed(const Duration(milliseconds: 1000));
    final List<GroceryItem> results = data.map<GroceryItem>((json) => GroceryItem.fromJson(json)).toList();
    return results;
  }

  Future<GroceryItem> create(String name, Category? category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final groceryItem = GroceryItem.fromJson({
      'id': 99,
      'name': name,
      'category': category != null ? GroceryItem.stringFromCategory(category) : null,
      'is_purchased': false
    });

    return groceryItem;
  }
}

GroceryItemService _export(){
  final service = Provider((ref) => GroceryItemService());
  final container = ProviderContainer();
  return container.read(service);
}

final groceryItemService = _export();