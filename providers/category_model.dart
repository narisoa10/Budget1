import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CategoryModel extends ChangeNotifier {
  List<String> _categories = [];
  List<String> _newCategories = [];
  final Box _categoryBox;

  CategoryModel(this._categoryBox) {
    _loadCategories();
  }

  List<String> get categories => _categories;
  List<String> get newCategories => _newCategories;

  // Метод для загрузки категорий из Hive
  Future<void> _loadCategories() async {
    _newCategories = _categoryBox.get('new_categories', defaultValue: <String>[])?.cast<String>() ?? [];
    _categories = [..._categoryBox.get('categories', defaultValue: <String>[])?.cast<String>() ?? [], ..._newCategories];
    notifyListeners();
  }

  // Добавление новой категории
  Future<void> addCategory(String newCategory) async {
    _newCategories.add(newCategory);
    _categories.add(newCategory);
    await _categoryBox.put('new_categories', _newCategories);
    notifyListeners();
  }

  // Удаление категории
  Future<void> removeCategory(int index) async {
    _newCategories.remove(_categories[index]);
    _categories.removeAt(index);
    await _categoryBox.put('new_categories', _newCategories);
    notifyListeners();
  }

  // Переименование категории
  Future<void> renameCategory(int index, String newName) async {
    int newCategoryIndex = _newCategories.indexOf(_categories[index]);
    _newCategories[newCategoryIndex] = newName;
    _categories[index] = newName;
    await _categoryBox.put('new_categories', _newCategories);
    notifyListeners();
  }
}
