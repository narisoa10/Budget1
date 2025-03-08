import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart'; // Нужен для форматирования дат.

class SettingsModel extends ChangeNotifier {
  final Box _settingsBox;

  // Основные параметры
  String _selectedLanguage;
  String _selectedCurrency;

  // Финансовые показатели
  double _totalIncome;
  double _totalExpense;

  // Пороговые значения
  double _warningThreshold = 20.0; // Предупреждение, в процентах
  double _criticalThreshold = 10.0; // Критический порог, в процентах

  // Данные категорий (хранение суммы и даты изменения)
  final Map<String, Map<String, dynamic>> _categoryData = {
    'charity': {'totalExpense': 0.0, 'lastUpdated': null},
    'clothing': {'totalExpense': 0.0, 'lastUpdated': null},
    'debt': {'totalExpense': 0.0, 'lastUpdated': null},
    'education': {'totalExpense': 0.0, 'lastUpdated': null},
    'entertainment': {'totalExpense': 0.0, 'lastUpdated': null},
    'food': {'totalExpense': 0.0, 'lastUpdated': null},
    'health': {'totalExpense': 0.0, 'lastUpdated': null},
    'housing': {'totalExpense': 0.0, 'lastUpdated': null},
    'insurance': {'totalExpense': 0.0, 'lastUpdated': null},
    'miscellaneous': {'totalExpense': 0.0, 'lastUpdated': null},
    'personal_category': {'totalExpense': 0.0, 'lastUpdated': null},
    'transport': {'totalExpense': 0.0, 'lastUpdated': null},
  };

  List<Map<String, dynamic>> _expenseReport = [];
  List<List<String>> _tableData = [];

  SettingsModel(this._settingsBox)
      : _selectedLanguage = _settingsBox.get('selectedLanguage') ?? _getDefaultLanguage(),
        _selectedCurrency = _settingsBox.get('selectedCurrency') ?? '€',
        _totalIncome = _settingsBox.get('totalIncome', defaultValue: 0.0) as double,
        _totalExpense = _settingsBox.get('totalExpense', defaultValue: 0.0) as double,
        _warningThreshold = _settingsBox.get('warningThreshold', defaultValue: 20.0) as double,
        _criticalThreshold = _settingsBox.get('criticalThreshold', defaultValue: 10.0) as double {
    final savedCategoryData = _settingsBox.get('categoryData', defaultValue: {});
    _categoryData.addAll(
      (savedCategoryData as Map).map((key, value) {
        return MapEntry(
          key as String,
          Map<String, dynamic>.from(value as Map),
        );
      }),
    );

    checkAndCopyMonthlyData(); // Проверка на смену месяца
    _loadExpenseReport();
    loadTableData();
    notifyListeners();
  }

  static String _getDefaultLanguage() {
    final deviceLocale = PlatformDispatcher.instance.locale.languageCode;
    return ['en', 'de', 'fr', 'it', 'es', 'pt', 'pl', 'uk', 'ru'].contains(deviceLocale)
        ? deviceLocale
        : 'en';
  }

  // Геттеры
  String get selectedLanguage => _selectedLanguage;
  String get selectedCurrency => _selectedCurrency;
  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;
  double get warningThreshold => _warningThreshold;
  double get criticalThreshold => _criticalThreshold;
  Map<String, Map<String, dynamic>> get categoryData => _categoryData;

  // Обновление общего дохода
  void updateTotalIncome(double newIncome) {
    _totalIncome = newIncome;
    _settingsBox.put('totalIncome', _totalIncome);
    notifyListeners();
  }

  // Обновление общего расхода
  void recalculateTotalExpense() {
    _totalExpense = _categoryData.values.fold(
      0.0,
          (sum, category) => sum + (category['totalExpense'] ?? 0.0),
    );

    _settingsBox.put('totalExpense', _totalExpense);
    notifyListeners();
  }

  // Установка языка
  void setLanguage(String newLanguage) {
    _selectedLanguage = newLanguage;
    _settingsBox.put('selectedLanguage', newLanguage);
    notifyListeners();
  }

  // Установка валюты
  void setCurrency(String newCurrency) {
    _selectedCurrency = newCurrency;
    _settingsBox.put('selectedCurrency', newCurrency);
    notifyListeners();
  }

  // Установка пороговых значений
  void updateThresholds({required double warning, required double critical}) {
    _warningThreshold = warning;
    _criticalThreshold = critical;

    _settingsBox.put('warningThreshold', _warningThreshold);
    _settingsBox.put('criticalThreshold', _criticalThreshold);

    notifyListeners();
  }

  // Обновление данных категории
  void updateCategoryExpense(String categoryName, double newExpense) {
    if (_categoryData.containsKey(categoryName)) {
      _categoryData[categoryName] = {
        'totalExpense': newExpense,
        'lastUpdated': DateTime.now(),
      };

      _settingsBox.put('categoryData', _categoryData);
      recalculateTotalExpense();
    }
  }

  // Сохранение расходов категории
  void saveCategoryExpense({
    required String mainCategory,
    required String subCategory,
    required double amount,
    required String date,
  }) {
    final expenseEntry = {
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'amount': amount,
      'date': date,
    };

    _expenseReport.add(expenseEntry);

    final currentTotal = _categoryData[mainCategory]?['totalExpense'] ?? 0.0;
    _categoryData[mainCategory] = {
      'totalExpense': currentTotal + amount,
      'lastUpdated': DateTime.now(),
    };

    recalculateTotalExpense();
    _saveExpenseReport();
  }

  // Форматирование дат
  String formatDate(DateTime? date) {
    if (date == null) return 'No updates';
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  // Сохранение отчета о расходах
  void _saveExpenseReport() {
    _settingsBox.put('expenseReport', _expenseReport);
  }

  // Загрузка отчета о расходах
  void _loadExpenseReport() {
    final loadedReport = _settingsBox.get('expenseReport', defaultValue: []);
    _expenseReport = List<Map<String, dynamic>>.from(
      (loadedReport as List).map((item) => Map<String, dynamic>.from(item as Map)),
    );
  }

  // Загрузка данных таблицы
  Future<List<List<String>>> loadTableData() async {
    final now = DateTime.now();
    final currentMonthKey = 'tableRows_${now.year}${now.month.toString().padLeft(2, '0')}';
    List<dynamic> storedData = _settingsBox.get(currentMonthKey, defaultValue: []);
    _tableData = storedData.map((row) => List<String>.from(row)).toList();
    return _tableData;
  }

  // Сохранение данных таблицы
  Future<void> saveTableData(List<List<String>> data) async {
    final now = DateTime.now();
    final currentMonthKey = 'tableRows_${now.year}${now.month.toString().padLeft(2, '0')}';
    _tableData = data;
    await _settingsBox.put(currentMonthKey, data);
    notifyListeners();
  }

  // Проверка и копирование данных на новый месяц
  void checkAndCopyMonthlyData() {
    final now = DateTime.now();
    final currentMonthKey = 'tableRows_${now.year}${now.month.toString().padLeft(2, '0')}';
    final previousMonthKey = now.month == 1
        ? 'tableRows_${(now.year - 1)}12'
        : 'tableRows_${now.year}${(now.month - 1).toString().padLeft(2, '0')}';

    // Если данных за текущий месяц нет
    if (!_settingsBox.containsKey(currentMonthKey)) {
      if (_settingsBox.containsKey(previousMonthKey)) {
        final previousData = _settingsBox.get(previousMonthKey);
        _settingsBox.put(currentMonthKey, previousData);
      } else {
        _settingsBox.put(currentMonthKey, []);
      }
    }
  }
}
