import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget1/models/item_table1.dart';
import '../localization/localization.dart';

class Table1DataModel extends ChangeNotifier with WidgetsBindingObserver {
  List<ItemTable1> _data = [];
  bool _isExpanded = true;
  double _totalSum = 0.0;
  final Box<ItemTable1> _box;
  final Box _settingsBox;  // Бокс для сохранения настроек

  Table1DataModel(this._box, this._settingsBox) {
    _loadFromHive();
    _calculateSum();  // Обновляем сумму
    WidgetsBinding.instance.addObserver(this);  // Подписываемся на жизненный цикл
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);  // Отписываемся
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _saveToHive();  // Сохраняем перед выходом
    }
  }

  List<ItemTable1> get data => _data;
  bool get isExpanded => _isExpanded;
  double get totalSum => _totalSum;

  // Обновляем флаг
  void setExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
    _saveToHive();
  }

  // Добавляем строку с переводом для 'name'
  void addRow() {
    _data.add(ItemTable1(
      name: Localization.getTranslation('name'),  // Используем локализацию для 'name'
      pricePerUnit: 0.0,
      quantity: 0.0,
      total: 0.0,
    ));
    _calculateSum();
    notifyListeners();
    _saveToHive();
  }

  // Удаляем строку
  void removeRow() {
    if (_data.isNotEmpty) {
      _data.removeLast();
      _calculateSum();
      notifyListeners();
      _saveToHive();
    }
  }

  // Обновляем строку
  void updateRow(int index, ItemTable1 updatedRow) {
    if (index >= 0 && index < _data.length) {
      _data[index] = updatedRow;
      _calculateSum();
      notifyListeners();
      _saveToHive();
    }
  }

  // Обновляем сумму
  void updateTotalSum(double newTotalSum) {
    _totalSum = newTotalSum;
    notifyListeners();
    _saveToHive();
  }

  // Пересчитываем общую сумму
  void _calculateSum() {
    _totalSum = _data.fold(0.0, (sum, item) => sum + (item.pricePerUnit * item.quantity));
  }

  // Сохраняем в Hive
  Future<void> _saveToHive() async {
    await _box.clear();  // Очищаем бокс перед сохранением
    await _box.addAll(_data);  // Сохраняем все объекты

    // Сохраняем настройки
    await _settingsBox.put('isExpanded', _isExpanded);
  }

  // Загружаем из Hive
  void _loadFromHive() {
    _data = _box.values.toList().cast<ItemTable1>();  // Загружаем данные

    // Загружаем настройки
    _isExpanded = _settingsBox.get('isExpanded', defaultValue: true) as bool;
    _calculateSum();
    notifyListeners();
  }

  // Обновляем перевод при смене локали
  void updateLocalization() {
    // Обновляем строки таблицы
    for (var i = 0; i < _data.length; i++) {
      if (_data[i].name == Localization.getTranslation('name')) {
        _data[i] = _data[i].copyWith(name: Localization.getTranslation('name'));
      }
    }

    notifyListeners();
  }
}
