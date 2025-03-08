import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> charityProviders(Box settingsBox) async {
  // Открываем бокс для категории благотворительных пожертвований
  final charityBox = await Hive.openBox<ItemTable1>('charity_donations');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(charityBox, settingsBox),
    ),
  ];
}
