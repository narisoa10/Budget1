import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../providers/table3_data_model.dart';

Future<List<ChangeNotifierProvider<Table3DataModel>>> debtProviders(Box settingsBox) async {
  String date = settingsBox.get('date', defaultValue: ''); // Значение по умолчанию
  String creditor = settingsBox.get('creditor', defaultValue: '');
  double amount = settingsBox.get('amount', defaultValue: 0.0);
  double totalExpense = settingsBox.get('totalExpense', defaultValue: 0.0); // Предполагаем, что totalExpense также хранится в settingsBox

  return [
    ChangeNotifierProvider(
      create: (_) => Table3DataModel(
        date: date,
        creditor: creditor,
        amount: amount,
        totalExpense: totalExpense, // Передаем totalExpense в конструктор
      ),
    ),
  ];
}

