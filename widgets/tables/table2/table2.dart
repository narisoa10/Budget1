import 'package:flutter/material.dart';
import '../../../../localization/localization.dart';
import '../../../../styles/text_styles.dart';

class Table2 extends StatelessWidget {
  final double rowHeight;
  final List<double> columnWidthsPercent;
  final List<Map<String, dynamic>> expenseReport;

  const Table2({
    super.key,
    this.rowHeight = 23,
    this.columnWidthsPercent = const [0.7, 0.3], // Две колонки: Категория и Сумма
    required this.expenseReport,
  });

  @override
  Widget build(BuildContext context) {
    // Обновленные заголовки для таблицы
    List<String> headers = [
      Localization.getTranslation('expense_category'),
      Localization.getTranslation('total'),
    ];

    // Формируем данные для таблицы, используя поля 'mainCategory' и 'totalAmount'
    List<List<String>> tableData = [
      headers,
      ...expenseReport.map((entry) {
        return [
          Localization.getTranslation(entry['mainCategory'] ?? 'Unknown'), // Категория
          entry['totalAmount']?.toString() ?? '0.0',                       // Итоговая сумма по категории
        ];
      }),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Рассчитываем абсолютную ширину для каждого столбца
            List<double> columnWidths = columnWidthsPercent.map((percent) {
              return constraints.maxWidth * percent;
            }).toList();

            return Table(
              border: TableBorder.all(width: 0.2, color: Colors.black),
              columnWidths: {
                0: FixedColumnWidth(columnWidths[0]), // Фиксированная ширина для категории
                1: FixedColumnWidth(columnWidths[1]), // Фиксированная ширина для суммы
              },
              children: tableData.map((row) {
                int rowIndex = tableData.indexOf(row);
                return TableRow(
                  children: List.generate(row.length, (colIndex) {
                    if (rowIndex == 0) {
                      // Заголовок
                      return Container(
                        height: rowHeight,
                        alignment: Alignment.center,
                        child: Text(
                          row[colIndex],
                          style: TextStyles.bodyText4,
                        ),
                      );
                    } else {
                      // Данные
                      return Container(
                        height: rowHeight,
                        alignment: Alignment.center,
                        child: Text(
                          row[colIndex],
                          style: TextStyles.bodyText7,
                        ),
                      );
                    }
                  }),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 3),
      ],
    );
  }
}
