import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Table0DataModel extends ChangeNotifier {
  final Box _tableBox;  // Hive Box для хранения данных таблицы
  List<Map<String, String>> _data = [];  // Данные для таблицы

  Table0DataModel(this._tableBox) {
    _loadFromHive();  // Загрузка данных при инициализации
  }

  List<Map<String, String>> get data => _data;  // Геттер для данных таблицы

  // Метод для добавления новой строки
  void addRow() {
    _data.add({'label': 'Label', 'value': '0.00'});
    _saveToHive();  // Сохранение данных в Hive
    notifyListeners();  // Уведомление слушателей об изменениях
  }

  // Метод для удаления последней строки
  void removeRow() {
    if (_data.isNotEmpty) {
      _data.removeLast();
      _saveToHive();  // Сохранение данных после удаления
      notifyListeners();  // Уведомление слушателей
    }
  }

  // Метод для обновления строки
  void updateRow(int index, String label, String value) {
    _data[index] = {'label': label, 'value': value};
    _saveToHive();  // Сохранение изменений в Hive
    notifyListeners();  // Уведомление слушателей
  }

  // Загрузка данных из Hive
  void _loadFromHive() {
    List<dynamic> rawData = _tableBox.get('table0Data', defaultValue: []);  // Загружаем как List<dynamic>
    _data = rawData.map((e) => Map<String, String>.from(e as Map)).toList();  // Приводим к List<Map<String, String>>
  }

  // Сохранение данных в Hive
  Future<void> _saveToHive() async {
    await _tableBox.put('table0Data', _data.map((row) => row.cast<String, dynamic>()).toList());
  }
}
