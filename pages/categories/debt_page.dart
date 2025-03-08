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
import '../../widgets/tables/table3/table3.dart';

class DebtPage extends StatefulWidget {
  final String selectedCurrency;

  const DebtPage({
    super.key,
    required this.selectedCurrency,
  });

  @override
  DebtPageState createState() => DebtPageState();
}

class DebtPageState extends State<DebtPage> {
  final String _category = "debt";

  double _totalExpense = 0.0; // Для хранения текущей общей суммы расходов
  final Map<String, double> _categoryExpenses = {}; // Расходы по подкатегориям
  bool _areBoxesOpened = false;
  late Box settingsBox;

  @override
  void initState() {
    super.initState();
    _initializeCategoryExpenses();
    _loadSettings();
  }

  void _initializeCategoryExpenses() {
    // Здесь вы можете инициализировать фиксированные категории, если они есть
    _categoryExpenses["debts_loans"] = 0.0; // Пример подкатегории
  }

  Future<void> _loadSettings() async {
    settingsBox = await Hive.openBox('settings');
    setState(() {
      _areBoxesOpened = true;
    });
  }

  void _updateCategoryExpense(String subCategory, double newSum) {
    if (_categoryExpenses[subCategory] != newSum) {
      setState(() {
        _categoryExpenses[subCategory] = newSum;
        _totalExpense = _categoryExpenses.values
            .reduce((sum, item) => sum + item); // Пересчитываем общую сумму
      });

      var settingsModel = Provider.of<SettingsModel>(context, listen: false);

      settingsModel.saveCategoryExpense(
        mainCategory: _category,
        subCategory: subCategory,
        amount: newSum,
        date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      );

      settingsModel.updateCategoryExpense(_category, _totalExpense);
    }
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = Localization.getTranslation('debt');

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
            child: Table3(
              onExpenseReportUpdated: (newSum) {
                _updateCategoryExpense("debts_loans", newSum);
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: TotalContainer(
              selectedCurrency: widget.selectedCurrency,
              categoryName: _category,
            ),
          ),
        ],
      ),
    );
  }
}
