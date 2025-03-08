import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> insuranceProviders(Box settingsBox) async {
  // Открываем бокс для категории страхования
  final insuranceBox = await Hive.openBox<ItemTable1>('ins_insurance');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(insuranceBox, settingsBox),
    ),
  ];
}
