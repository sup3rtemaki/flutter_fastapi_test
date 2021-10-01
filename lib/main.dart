import 'package:flutter/material.dart';
import 'package:flutter_fastapi_test/providers/grocery_item_form_provider.dart';
import 'package:flutter_fastapi_test/providers/grocery_list_provider.dart';
import 'package:flutter_fastapi_test/screens/add_grocery_item_screen.dart';
import 'package:flutter_fastapi_test/screens/list_screen.dart';
import 'package:flutter_fastapi_test/theme.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupSingletons();
  runApp(MyApp());
}

void setupSingletons() {
  getIt.registerSingleton<GroceryItemFormProvider>(
    GroceryItemFormProviderImplementation(),
      signalsReady: true
  );

  getIt.registerSingleton<GroceryListProvider>(
      GroceryListProviderImplementation(),
      signalsReady: true
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: ThemeColors.primary,
      ),
      routes: {
        '/': (ctx) => ListScreen(),
        AddGroceryItemScreen.routeName: (ctx) => AddGroceryItemScreen(),
      },
    );
  }
}