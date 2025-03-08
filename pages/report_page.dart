import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../localization/localization.dart';
import '../providers/settings_model.dart';
import '../styles/text_styles.dart';
import '../styles/app_colors.dart';
import '../widgets/tables/table2/table2.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  String selectedPeriod = 'week';
  late SettingsModel _settingsModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Получаем актуальный SettingsModel через Provider
    _settingsModel = Provider.of<SettingsModel>(context);
  }

  bool isDataEmpty(double income, double expense, double balance) {
    return income == 0.0 && expense == 0.0 && balance == 0.0;
  }

  Map<String, Map<String, dynamic>> getFilteredData(
      Map<String, Map<String, dynamic>> categoryData, String period) {
    DateTime now = DateTime.now();
    DateTime startDate;

    if (period == 'week') {
      startDate = now.subtract(Duration(days: 7));
    } else if (period == 'month') {
      startDate = DateTime(now.year, now.month - 1, now.day);
    } else {
      startDate = DateTime(now.year, 1, 1);
    }

    return Map.fromEntries(
      categoryData.entries.where((entry) {
        final lastUpdated = entry.value['lastUpdated'] as DateTime?;
        return lastUpdated != null && lastUpdated.isAfter(startDate);
      }),
    );
  }

  List<ChartData> createMainCategoryData(double totalIncome, double totalExpense) {
    double balance = totalIncome - totalExpense;

    return [
      ChartData(
        Localization.getTranslation('expense'),
        totalExpense,
        AppColors.expense1ButtonColor,
      ),
      ChartData(
        Localization.getTranslation('balance'),
        balance,
        AppColors.generalPageColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Гарантированно получаем значения из SettingsModel
    final totalIncome = _settingsModel.totalIncome;
    final totalExpense = _settingsModel.totalExpense;
    final totalBalance = totalIncome - totalExpense;
    final selectedCurrency = _settingsModel.selectedCurrency;
    final categoryData = _settingsModel.categoryData;
    final filteredData = getFilteredData(categoryData, selectedPeriod);
    final mainCategoryData = createMainCategoryData(totalIncome, totalExpense);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  Localization.getTranslation('final_report'),
                  style: TextStyles.zagolovka,
                ),
              ),
              const SizedBox(height: 20),

              // Выбор периода
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    value: selectedPeriod,
                    items: [
                      DropdownMenuItem(
                        value: 'week',
                        child: Text(Localization.getTranslation('week')),
                      ),
                      DropdownMenuItem(
                        value: 'month',
                        child: Text(Localization.getTranslation('month')),
                      ),
                      DropdownMenuItem(
                        value: 'year',
                        child: Text(Localization.getTranslation('year')),
                      ),
                    ],
                    onChanged: (newPeriod) {
                      if (newPeriod != null) {
                        setState(() {
                          selectedPeriod = newPeriod;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Диаграмма или сообщение "Нет данных"
              SizedBox(
                height: 250,
                child: isDataEmpty(totalIncome, totalExpense, totalBalance)
                    ? Center(
                  child: Text(
                    Localization.getTranslation('no_data_available'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.top,
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: mainCategoryData,
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.amount,
                      pointColorMapper: (ChartData data, _) => data.color,
                      dataLabelMapper: (ChartData data, _) {
                        return NumberFormat.currency(
                          locale: 'en_US',
                          symbol: selectedCurrency,
                        ).format(data.amount);
                      },
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      innerRadius: '70%',
                    ),
                  ],
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Localization.getTranslation('income'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.incomeButtonColor,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'en_US',
                              symbol: selectedCurrency,
                            ).format(totalIncome),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.incomeButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Text(
                  Localization.getTranslation('expense_by_category'),
                  style: TextStyles.zagolovka,
                ),
              ),
              const SizedBox(height: 10),

              Table2(
                rowHeight: 23,
                columnWidthsPercent: const [0.5, 0.5],
                expenseReport: filteredData.entries
                    .map((entry) => {
                  'mainCategory': Localization.getTranslation(entry.key),
                  'totalAmount': entry.value['totalExpense'] ?? 0.0,
                })
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double amount;
  final Color color;

  ChartData(this.category, this.amount, this.color);
}
