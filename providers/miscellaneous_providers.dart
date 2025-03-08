import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> miscellaneousProviders(Box settingsBox) async {
  // Открываем бокс для категории случайных расходов
  final miscExpensesBox = await Hive.openBox<ItemTable1>('misc_expenses');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(miscExpensesBox, settingsBox),
    ),
  ];
}
