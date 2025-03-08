import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_model.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../widgets/appbars/custom_app_bar.dart';
import '../../widgets/appbars/total_container.dart';
import '../../localization/localization.dart';
import '../../widgets/tables/table1/table1.dart';
import '../../providers/table1_data_model.dart';
import '../../models/item_table1.dart';

class CharityPage extends StatefulWidget {
  final String selectedCurrency;

  const CharityPage({
    super.key,
    required this.selectedCurrency,
  });

  @override
  CharityPageState createState() => CharityPageState();
}

class CharityPageState extends State<CharityPage> {
  double _totalExpense = 0.0; // Общая сумма расходов
  final Map<String, double> _categoryExpenses = {}; // Расходы по подкатегориям

  bool _areBoxesOpened = false; // Флаг для проверки, открыты ли боксы
  late Box settingsBox; // Используем существующий бокс settings
  final List<String> _categories = ['charity_donations']; // Список категорий
  List<String> _newCategories = []; // Новодобавленные категории

  @override
  void initState() {
    super.initState();
    _initializeCategoryExpenses(); // Инициализируем расходы
    _loadSettings(); // Загружаем существующие данные
  }

  void _initializeCategoryExpenses() {
    for (var category in _categories) {
      _categoryExpenses[category] = 0.0; // Устанавливаем начальные значения расходов
    }
  }

  Future<void> _loadSettings() async {
    settingsBox = await Hive.openBox('settings'); // Открытие бокса settings

    List<String>? savedNewCategories =
    settingsBox.get('charity_new_categories')?.cast<String>();
    if (savedNewCategories != null) {
      _newCategories = savedNewCategories;

      for (String category in _newCategories) {
        String encodedBoxName = _encodeCategoryName(category);
        if (!Hive.isBoxOpen(encodedBoxName)) {
          await Hive.openBox<ItemTable1>(encodedBoxName); // Открываем боксы для новых категорий
        }
      }
    }

    setState(() {
      _areBoxesOpened = true; // Установка флага, что боксы загружены
    });
  }

  Future<void> _saveNewCategories() async {
    await settingsBox.put('charity_new_categories', _newCategories);
  }

  Future<void> _addNewCategory(String categoryName) async {
    if (categoryName.isNotEmpty &&
        !_categories.contains(categoryName) &&
        !_newCategories.contains(categoryName)) {
      String encodedBoxName = _encodeCategoryName(categoryName);

      if (!Hive.isBoxOpen(encodedBoxName)) {
        await Hive.openBox<ItemTable1>(encodedBoxName); // Открываем новый бокс
      }

      setState(() {
        _newCategories.add(categoryName);
        _categoryExpenses[categoryName] = 0.0; // Добавляем категорию в расходы
      });

      await _saveNewCategories();
    }
  }

  Future<void> _removeCategory(String categoryName) async {
    if (_newCategories.contains(categoryName)) {
      String encodedBoxName = _encodeCategoryName(categoryName);

      if (Hive.isBoxOpen(encodedBoxName)) {
        await Hive.deleteBoxFromDisk(encodedBoxName); // Удаляем бокс с данными
      }

      setState(() {
        _newCategories.remove(categoryName);
        _categoryExpenses.remove(categoryName); // Удаляем из расчетов
        _totalExpense = _categoryExpenses.values
            .reduce((sum, item) => sum + item); // Пересчитываем общую сумму
      });

      await _saveNewCategories();
    }
  }

  String _encodeCategoryName(String categoryName) {
    return Uri.encodeComponent(categoryName);
  }

  void _updateCategoryExpense(String category, double newSum) {
    if (_categoryExpenses[category] != newSum) {
      setState(() {
        _categoryExpenses[category] = newSum;
        _totalExpense = _categoryExpenses.values
            .reduce((sum, item) => sum + item); // Пересчитываем общую сумму
      });

      var settingsModel = Provider.of<SettingsModel>(context, listen: false);

      // Сохраняем расходы и дату в модели настроек
      settingsModel.saveCategoryExpense(
        mainCategory: "charity",
        subCategory: category,
        amount: newSum,
        date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      );

      settingsModel.updateCategoryExpense("charity", _totalExpense);
    }
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = Localization.getTranslation('charity'); // Заголовок страницы

    if (!_areBoxesOpened) {
      return Scaffold(
        appBar: CustomAppBar(
          scaffoldKey: GlobalKey<ScaffoldState>(),
          backgroundColor: Colors.white,
          cardColor: AppColors.expense1PageColor,
          automaticallyImplyLeading: false,
        ),
        body: const Center(
          child: SpinKitThreeBounce(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        scaffoldKey: GlobalKey<ScaffoldState>(),
        backgroundColor: Colors.white,
        cardColor: AppColors.expense1PageColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              pageTitle,
              style: TextStyles.zagolovka,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: (_categories + _newCategories).map((category) {
                return _buildCategoryTable(
                  category,
                  Localization.getTranslation(category),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _showRemoveCategoryDialog(),
                  child: Text(Localization.getTranslation("remove_table")),
                ),
                ElevatedButton(
                  onPressed: () => _showAddCategoryDialog(),
                  child: Text(Localization.getTranslation("add_table")),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: TotalContainer(
              selectedCurrency: widget.selectedCurrency,
              categoryName: 'charity',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTable(String categoryKey, String title) {
    final encodedBoxName = _encodeCategoryName(categoryKey);

    if (!Hive.isBoxOpen(encodedBoxName)) {
      return const SizedBox();
    }

    final categoryBox = Hive.box<ItemTable1>(encodedBoxName);

    return ChangeNotifierProvider(
      create: (_) => Table1DataModel(categoryBox, settingsBox),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Table1(
          title: title,
          onTotalSumChanged: (newSum) => _updateCategoryExpense(categoryKey, newSum),
        ),
      ),
    );
  }

  void _showAddCategoryDialog() {
    String newCategoryName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(Localization.getTranslation('add_table')),
          content: TextField(
            onChanged: (value) {
              newCategoryName = value;
            },
            decoration: InputDecoration(
              hintText: Localization.getTranslation('enter_subcategory'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(Localization.getTranslation('cancel')),
            ),
            TextButton(
              onPressed: () {
                _addNewCategory(newCategoryName);
                Navigator.of(context).pop();
              },
              child: Text(Localization.getTranslation('add')),
            ),
          ],
        );
      },
    );
  }

  void _showRemoveCategoryDialog() {
    String categoryNameToRemove = '';

    showDialog(
        context: context,
        builder: (context) {
      return AlertDialog(
          title: Text(Localization.getTranslation('remove_table')),
          content: DropdownButton<String>(
            isExpanded: true,
            value: categoryNameToRemove.isNotEmpty ? categoryNameToRemove : null,
            items: _newCategories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                categoryNameToRemove = value ?? '';
              });
            },
          ),
          actions: [
          TextButton(
          onPressed: () => Navigator.of(context).pop(),
    child: Text(Localization.getTranslation('cancel')),
          ),
          TextButton(
          onPressed: () {
          if (categoryNameToRemove.isNotEmpty) {
          _removeCategory(categoryNameToRemove);
          }
          Navigator.of(context).pop();
          },
          child: Text(Localization.getTranslation('remove')),
          ),
          ],
          );
        },
    );
  }
}
