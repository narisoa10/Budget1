import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../localization/localization.dart';
import '../../../styles/text_styles.dart';
import '../../../providers/table3_data_model.dart';
import '../../../providers/settings_model.dart';

class Table3 extends StatelessWidget {
  final double rowHeight;
  final List<double> columnWidthsPercent;
  final Function(double) onExpenseReportUpdated;

  const Table3({
    super.key,
    this.rowHeight = 25,
    this.columnWidthsPercent = const [0.4, 0.3, 0.3],
    required this.onExpenseReportUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final settingsModel = Provider.of<SettingsModel>(context);

    return Consumer<Table3DataModel>(
      builder: (context, model, child) {
        double totalExpense = model.getTotalExpense();

        // Обновляем общий расход в SettingsModel при каждом изменении таблицы
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onExpenseReportUpdated(totalExpense);
          settingsModel.updateCategoryExpense('Debt', totalExpense);
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                List<double> columnWidths = columnWidthsPercent.map((percent) {
                  return constraints.maxWidth * percent;
                }).toList();

                return Table(
                  border: TableBorder.all(width: 0.2, color: Colors.black),
                  columnWidths: {
                    0: FixedColumnWidth(columnWidths[0]),
                    1: FixedColumnWidth(columnWidths[1]),
                    2: FixedColumnWidth(columnWidths[2]),
                  },
                  children: [
                    TableRow(
                      children: [
                        Center(
                          child: Text(
                            Localization.getTranslation('date'),
                            style: TextStyles.bodyText5,
                          ),
                        ),
                        Center(
                          child: Text(
                            Localization.getTranslation('creditor'),
                            style: TextStyles.bodyText5,
                          ),
                        ),
                        const Center(
                          child: Text(
                            "\$",
                            style: TextStyles.bodyText5,
                          ),
                        ),
                      ],
                    ),
                    ...model.data.asMap().entries.map((entry) {
                      int rowIndex = entry.key;
                      List<String> row = entry.value;
                      return TableRow(
                        children: List.generate(row.length, (colIndex) {
                          if (colIndex == 0) {
                            return GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  model.updateRow(rowIndex, colIndex, picked.toString().split(' ')[0]);
                                }
                              },
                              child: Container(
                                height: rowHeight,
                                alignment: Alignment.center,
                                child: Text(
                                  row[colIndex].isNotEmpty
                                      ? row[colIndex]
                                      : Localization.getTranslation('chooseDate'),
                                  style: row[colIndex].isEmpty
                                      ? TextStyles.bodyText2
                                      : TextStyles.bodyText1,
                                ),
                              ),
                            );
                          } else if (colIndex == 2) {
                            return TextFormField(
                              initialValue: row[colIndex],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyles.bodyText1,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (newValue) {
                                model.updateRow(rowIndex, colIndex, newValue);

                                // Пересчитываем общий расход и обновляем его в SettingsModel
                                double newTotal = model.getTotalExpense();
                                settingsModel.updateCategoryExpense('Debt', newTotal);
                                onExpenseReportUpdated(newTotal);
                              },
                            );
                          } else {
                            return Container(
                              height: rowHeight,
                              alignment: Alignment.center,
                              child: TextFormField(
                                initialValue: row[colIndex],
                                onChanged: (newValue) {
                                  model.updateRow(rowIndex, colIndex, newValue);
                                },
                                textAlign: TextAlign.center,
                                style: TextStyles.bodyText1,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            );
                          }
                        }),
                      );
                    }),
                  ],
                );
              },
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    model.removeRow();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: 20.0,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    model.addRow();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 20.0,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
