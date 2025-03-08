import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Table3DataModel extends ChangeNotifier {
  String date;
  String creditor;
  double amount;
  double totalExpense;
  List<List<String>> data = [];

  Table3DataModel({
    required this.date,
    required this.creditor,
    required this.amount,
    this.totalExpense = 0.0,
  }) {
    loadTableData(); // Загружаем данные при инициализации
  }

  // Загружаем данные из Hive
  Future<void> loadTableData() async {
    final box = await Hive.openBox('settings');
    List<dynamic> storedData = box.get('table_data', defaultValue: []);
    data = storedData.map((row) => List<String>.from(row)).toList();
    totalExpense = getTotalExpense(); // Обновляем общий расход на основе загруженных данных
    notifyListeners();
  }

  // Сохраняем данные в Hive
  Future<void> saveTableData() async {
    final box = await Hive.openBox('settings');
    await box.put('table_data', data);
    await box.put('debts_loans_total_expense', getTotalExpense());
  }

  double getTotalExpense() {
    if (data.isEmpty) {
      return 0.0;
    }
    return data.map((row) => double.tryParse(row[2]) ?? 0.0).reduce((a, b) => a + b);
  }

  void updateRow(int rowIndex, int colIndex, String newValue) {
    data[rowIndex][colIndex] = newValue;
    saveTableData(); // Сохраняем данные при каждом обновлении строки
    notifyListeners();
  }

  void addRow() {
    data.add(['', '', '']);
    saveTableData(); // Сохраняем данные при добавлении строки
    notifyListeners();
  }

  void removeRow() {
    if (data.isNotEmpty) {
      data.removeLast();
      saveTableData(); // Сохраняем данные при удалении строки
      notifyListeners();
    }
  }
}
