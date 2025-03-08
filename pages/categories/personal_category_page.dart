import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../providers/settings_model.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../widgets/appbars/custom_app_bar.dart';
import '../../widgets/appbars/total_container.dart';
import '../../localization/localization.dart';
import '../../widgets/tables/table1/table1.dart';
import '../../providers/table1_data_model.dart';
import '../../models/item_table1.dart';

class PersonalCategoryPage extends StatefulWidget {
  final String selectedCurrency;

  const PersonalCategoryPage({
    super.key,
    required this.selectedCurrency,
  });

  @override
  PersonalCategoryPageState createState() => PersonalCategoryPageState();
}

class PersonalCategoryPageState extends State<PersonalCategoryPage> {
  double _totalExpense = 0.0; // Общая сумма расходов
  final Map<String, double> _categoryExpenses = {"personal_expense": 0.0};
  bool _areBoxesOpened = false;
  List<String> _newCategories = [];
  late Box settingsBox;
  String pageTitle = '';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    settingsBox = await Hive.openBox('settings');

    pageTitle = settingsBox.get('personal_category_title') ??
        Localization.getTranslation('personal_category');

    List<String>? savedNewCategories =
    settingsBox.get('personal_category_new_categories')?.cast<String>();
    if (savedNewCategories != null) {
      _newCategories = savedNewCategories;

      for (String category in _newCategories) {
        String encodedBoxName = _encodeCategoryName(category);
        if (!Hive.isBoxOpen(encodedBoxName)) {
          await Hive.openBox<ItemTable1>(encodedBoxName);
        }
      }
    }

    setState(() {
      _areBoxesOpened = true;
    });
  }

  @override
  void dispose() {
    _saveNewCategories();
    super.dispose();
  }

  Future<void> _saveNewCategories() async {
    await settingsBox.put('personal_category_new_categories', _newCategories);
  }

  Future<void> _savePageTitle(String newTitle) async {
    setState(() {
      pageTitle = newTitle;
    });
    await settingsBox.put('personal_category_title', newTitle);
  }

  void showEditTitleDialog() {
    TextEditingController titleController = TextEditingController(text: pageTitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(Localization.getTranslation('edit_page_title')),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: Localization.getTranslation('enter_new_title'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(Localization.getTranslation('cancel')),
            ),
            TextButton(
              onPressed: () {
                _savePageTitle(titleController.text);
                Navigator.of(context).pop();
              },
              child: Text(Localization.getTranslation('save')),
            ),
          ],
        );
      },
    );
  }

  String _encodeCategoryName(String categoryName) {
    return Uri.encodeComponent(categoryName);
  }

  void _updateCategoryExpense(String category, double newSum) {
    if (_categoryExpenses[category] != newSum) {
      setState(() {
        _categoryExpenses[category] = newSum;
        _totalExpense = _categoryExpenses.values.reduce((sum, item) => sum + item);
      });

      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      var settingsModel = Provider.of<SettingsModel>(context, listen: false);

      settingsModel.saveCategoryExpense(
        mainCategory: "personal_category",
        subCategory: category,
        amount: newSum,
        date: currentDate,
      );

      settingsModel.updateCategoryExpense("personal_category", _totalExpense);
    }
  }

  Future<void> _addNewCategory(String categoryName) async {
    if (categoryName.isNotEmpty && !_newCategories.contains(categoryName)) {
      String encodedBoxName = _encodeCategoryName(categoryName);

      if (!Hive.isBoxOpen(encodedBoxName)) {
        await Hive.openBox<ItemTable1>(encodedBoxName);
      }

      setState(() {
        _newCategories.add(categoryName);
        _categoryExpenses[categoryName] = 0.0; // Инициализируем новую категорию
      });

      await _saveNewCategories();
    }
  }

  Future<void> _removeCategory(String categoryName) async {
    if (_newCategories.contains(categoryName)) {
      String encodedBoxName = _encodeCategoryName(categoryName);

      if (Hive.isBoxOpen(encodedBoxName)) {
        await Hive.deleteBoxFromDisk(encodedBoxName);
      }

      setState(() {
        _newCategories.remove(categoryName);
        _categoryExpenses.remove(categoryName);
        _totalExpense = _categoryExpenses.values.fold(0.0, (sum, item) => sum + item);
      });

      await _saveNewCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pageTitle,
                  style: TextStyles.zagolovka,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => showEditTitleDialog(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: _newCategories.map((category) {
                return _buildCategoryTable(category, category);
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
              categoryName: 'personal_category',
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
              onPressed: () {
                Navigator.of(context).pop();
              },
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
          onPressed: () {
          Navigator.of(context).pop();
          },
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
