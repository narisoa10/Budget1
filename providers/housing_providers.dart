import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> housingProviders(Box settingsBox) async {
  final rentBox = await Hive.openBox<ItemTable1>('rent');
  final utilitiesBox = await Hive.openBox<ItemTable1>('utilities');
  final internetBox = await Hive.openBox<ItemTable1>('internet');
  final managementFeesBox = await Hive.openBox<ItemTable1>('management_fees');
  final maintenanceBox = await Hive.openBox<ItemTable1>('maintenance');
  final otherExpensesBox = await Hive.openBox<ItemTable1>('other_expenses');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(rentBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(utilitiesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(internetBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(managementFeesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(maintenanceBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(otherExpensesBox, settingsBox),
    ),
  ];
}
