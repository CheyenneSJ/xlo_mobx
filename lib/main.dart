import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

Future<void> getCep() async {
  final cep = await CepRepository().getAddressFromApi('79116230');
  log(cep.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  await getCep();
  runApp(const MyApp());

  // final category = ParseObject('Categories')
  //   ..set('Title', 'Camisetas')
  //   ..set('Position', 2);
  //
  // final response = await category.save();
  // print(response.success);

  // final category = ParseObject('Categories')..objectId = 'dhfdfdfhjfh';
  // category.delete();
  // final response = await ParseObject('Categories').getObject('3sjrVukFD5');
  // if (response.success) {
  //   print(response.result);

  // final response = await ParseObject('Categories').getAll();
  // if (response.success) {
  //   for (final object in response.result) {
  //     print(object);
  //   }
  // }

  // final query = QueryBuilder(ParseObject('Categories'));
  //
  // query.whereEqualTo('Position', 2);
  //
  // final response = await query.query();
  // if (response.success) {
  //   print(response.result);
  // }
}

void setupLocators() {
  GetIt.I.registerLazySingleton(() => PageStore());
  GetIt.I.registerLazySingleton(() => UserManagerStore());
  GetIt.I.registerLazySingleton(() => CategoryStore());
  GetIt.I.registerLazySingleton(() => CreateStore());
}

Future<void> initializeParse() async {
  await Parse().initialize(
    'Jq0sBXM92dhq9FO0nv6DiDeUosktCIv61ynEf7xM',
    'https://parseapi.back4app.com/',
    clientKey: 'LS7gDf8AupSKxLl1ZP9x4mymBhekzROMguWuESkh',
    autoSendSessionId: true,
    debug: true,
  );

  // final categories = await CategoryRepository().getList();
  // print(categories);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XLO',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.purple,
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: const BaseScreen(),
    );
  }
}
