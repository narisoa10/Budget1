import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../localization/localization.dart';
import '../../../styles/text_styles.dart';
import 'editable0_cell.dart';
import '../../../providers/settings_model.dart';

class Table0 extends StatefulWidget {
  final double rowHeight;
  final List<double> columnWidthsPercent;
  final Function(double) onIncomeUpdated;

  const Table0({
    super.key,
    this.rowHeight = 25,
    this.columnWidthsPercent = const [0.4, 0.3, 0.3],
    required this.onIncomeUpdated,
  });

  @override
  Table0State createState() => Table0State();
}

class Table0State extends State<Table0> {
  List<List<String>> data = [];
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _loadData();  // Загружаем данные при инициализации
  }

  // Метод для загрузки данных из Hive
  Future<void> _loadData() async {
    // Загружаем данные таблицы из SettingsModel
    final settings = Provider.of<SettingsModel>(context, listen: false);
    data = await settings.loadTableData();  // Получаем загруженные данные
    _updateTotalIncome();  // Пересчитываем общую сумму после загрузки
    setState(() {});  // Обновляем интерфейс
    // Обновляем интерфейс
    // Обновляем интерфейс
  }

  // Метод для сохранения данных в Hive
  Future<void> _saveData() async {
    final settings = Provider.of<SettingsModel>(context, listen: false);
    await settings.saveTableData(data);  // Реализуйте этот метод в SettingsModel для сохранения данных в Hive
  }

  // Обновление общей суммы доходов и сохранение данных
  void _updateTotalIncome() {
    // Проверка, что список не пуст, прежде чем вызывать reduce
    if (data.isNotEmpty) {
      double totalIncome = data.map((row) => double.tryParse(row[2]) ?? 0.0).reduce((a, b) => a + b);
      Provider.of<SettingsModel>(context, listen: false).updateTotalIncome(totalIncome);
      widget.onIncomeUpdated(totalIncome); // Передаем сумму через callback
    } else {
      Provider.of<SettingsModel>(context, listen: false).updateTotalIncome(0.0);
      widget.onIncomeUpdated(0.0); // Передаем 0.0 при пустом списке
    }
    _saveData(); // Сохраняем обновленные данные таблицы
  }


  // Функция для выбора даты
  Future<void> _selectDate(BuildContext context, int rowIndex) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        data[rowIndex][0] = dateFormat.format(picked); // Обновляем дату
      });
      _saveData();  // Сохраняем данные после изменения даты
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> headers = [
      Localization.getTranslation('date'),
      Localization.getTranslation('your_income'),
      "\$",
    ];

    List<List<String>> tableData = [headers] + data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            List<double> columnWidths = widget.columnWidthsPercent.map((percent) {
              return constraints.maxWidth * percent;
            }).toList();

            return Table(
              border: TableBorder.all(width: 0.2, color: Colors.black),
              columnWidths: {
                0: FixedColumnWidth(columnWidths[0]),
                1: FixedColumnWidth(columnWidths[1]),
                2: FixedColumnWidth(columnWidths[2]),
              },
              children: tableData.map((row) {
                int rowIndex = tableData.indexOf(row);
                return TableRow(
                  children: List.generate(row.length, (colIndex) {
                    if (rowIndex == 0) {
                      return Container(
                        height: widget.rowHeight,
                        alignment: Alignment.center,
                        child: Text(
                          row[colIndex],
                          style: TextStyles.bodyText5,
                        ),
                      );
                    } else if (colIndex == 0) {
                      return GestureDetector(
                        onTap: () {
                          _selectDate(context, rowIndex - 1);
                        },
                        child: Container(
                          height: widget.rowHeight,
                          alignment: Alignment.center,
                          child: Text(
                            data[rowIndex - 1][colIndex].isNotEmpty
                                ? data[rowIndex - 1][colIndex]
                                : Localization.getTranslation('chooseDate'),
                            style: data[rowIndex - 1][colIndex].isEmpty
                                ? TextStyles.bodyText2
                                : TextStyles.bodyText1,
                          ),
                        ),
                      );
                    } else if (colIndex == 2) {
                      return Container(
                        height: widget.rowHeight,
                        alignment: Alignment.center,
                        child: TextFormField(
                          initialValue: row[colIndex],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyles.bodyText1,
                          cursorHeight: 20.0,
                          cursorWidth: 1.0,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            isDense: true,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              data[rowIndex - 1][colIndex] = newValue;
                              _updateTotalIncome();
                            });
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: widget.rowHeight,
                        alignment: Alignment.center,
                        child: Editable0Cell(
                          initialValue: row[colIndex],
                          textStyle: TextStyles.bodyText1,
                          onChanged: (newValue) {
                            setState(() {
                              data[rowIndex - 1][colIndex] = newValue;
                              _updateTotalIncome();
                            });
                          },
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (data.isNotEmpty) {
                    data.removeLast();
                    _updateTotalIncome();
                  }
                });
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
                setState(() {
                  data.add(['', '', '']);
                  _updateTotalIncome();
                });
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
  }
}
