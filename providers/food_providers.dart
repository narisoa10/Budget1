//import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> foodProviders(Box settingsBox) async {
  final vegetablesBox = await Hive.openBox<ItemTable1>('vegetables_fruits');
  final groceriesBox = await Hive.openBox<ItemTable1>('groceries');
  final meatFishBox = await Hive.openBox<ItemTable1>('meat_fish');
  final dairyProductsBox = await Hive.openBox<ItemTable1>('dairy_products');
  final bakeryProductsBox = await Hive.openBox<ItemTable1>('bakery_products');
  final drinksBox = await Hive.openBox<ItemTable1>('drinks');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(vegetablesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(groceriesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(meatFishBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(dairyProductsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(bakeryProductsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(drinksBox, settingsBox),
    ),
  ];
}
