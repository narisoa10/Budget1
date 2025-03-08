import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../localization/localization.dart';
import '../../../models/item_table1.dart';
import '../../../providers/settings_model.dart';
import '../../../providers/table1_data_model.dart';
import '../../../styles/text_styles.dart';
import 'table1_row.dart';


class Table1 extends StatefulWidget {
  final double rowHeight;
  final List<double> columnWidthsPercent;
  final IconData expandedIcon;
  final IconData collapsedIcon;
  final Color iconColor;
  final double iconSize;
  final ValueChanged<double> onTotalSumChanged;
  final String title;

  const Table1({
    super.key,
    this.rowHeight = 25,
    this.columnWidthsPercent = const [0.4, 0.25, 0.15, 0.2],
    this.expandedIcon = Icons.expand_less,
    this.collapsedIcon = Icons.expand_more,
    this.iconColor = Colors.black,
    this.iconSize = 24.0,
    required this.onTotalSumChanged,
    required this.title,
  });

  @override
  Table1State createState() => Table1State();
}

class Table1State extends State<Table1> {
  late String name1Translation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
      _updateTotalSum();
    });
    name1Translation = Localization.getTranslation('name1');
  }

  void _initializeData() {
    var tableModel = Provider.of<Table1DataModel>(context, listen: false);
    if (tableModel.data.isEmpty) {
      tableModel.addRow();
    }
  }

  void _updateTotalSum() {
    var tableModel = Provider.of<Table1DataModel>(context, listen: false);
    double newTotalSum = tableModel.data.fold(0.0, (sum, item) {
      return sum + (item.pricePerUnit * item.quantity);
    });
    tableModel.updateTotalSum(newTotalSum);
    widget.onTotalSumChanged(newTotalSum);

    // Внутри метода обновления суммы расходов в Table1
    final settingsModel = Provider.of<SettingsModel>(context, listen: false);

// Вызываем updateConfirmedExpense только после подтвержденного изменения
    settingsModel.updateCategoryExpense(widget.title, newTotalSum);

  }

  @override
  Widget build(BuildContext context) {
    var tableModel = Provider.of<Table1DataModel>(context);

    // Локализованные заголовки таблицы
    List<String> headers = [
      Localization.getTranslation('name'),
      Localization.getTranslation('price_per_unit'),
      Localization.getTranslation('quantity'),
      Localization.getTranslation('total'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExpandableRow(tableModel, widget.title),
        if (tableModel.isExpanded)
          LayoutBuilder(
            builder: (context, constraints) {
              List<double> columnWidths = widget.columnWidthsPercent.map((percent) {
                return constraints.maxWidth * percent;
              }).toList();

              return Column(
                children: [
                  Table(
                    border: TableBorder.all(width: 0.2, color: Colors.black),
                    columnWidths: {
                      0: FixedColumnWidth(columnWidths[0]),
                      1: FixedColumnWidth(columnWidths[1]),
                      2: FixedColumnWidth(columnWidths[2]),
                      3: FixedColumnWidth(columnWidths[3]),
                    },
                    children: [
                      _buildTableHeaderRow(headers),
                      ...tableModel.data.map((item) => Table1Row(
                        rowData: [
                          item.name.isEmpty ? name1Translation : item.name,
                          item.pricePerUnit.toString(),
                          item.quantity.toString(),
                          item.total.toString(),
                        ],
                        rowHeight: widget.rowHeight,
                        textStyle: TextStyles.bodyText1,
                        onChanged: (updatedRow) {
                          var pricePerUnit = double.tryParse(updatedRow[1]) ?? 0.0;
                          var quantity = updatedRow[2] is int
                              ? (updatedRow[2] as int).toDouble()
                              : double.tryParse(updatedRow[2]) ?? 0.0;
                          var total = pricePerUnit * quantity;

                          var updatedItem = ItemTable1(
                            name: updatedRow[0].isEmpty ? name1Translation : updatedRow[0],
                            pricePerUnit: pricePerUnit,
                            quantity: quantity,
                            total: total,
                          );

                          tableModel.updateRow(tableModel.data.indexOf(item), updatedItem);
                          _updateTotalSum(); // Обновляем общую сумму после изменений
                        },
                      ).toTableRow(headers.length)),
                    ],
                  ),
                  _buildActionButtons(tableModel),
                ],
              );
            },
          ),
      ],
    );
  }

  // Строка с заголовком и кнопкой сворачивания
  Widget _buildExpandableRow(Table1DataModel tableModel, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Уменьшение отступа сверху и снизу
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Заголовок категории
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          // Кнопка сворачивания
          InkWell(
            onTap: () {
              tableModel.setExpanded(!tableModel.isExpanded);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),  // Небольшой отступ справа
              child: Icon(
                tableModel.isExpanded ? widget.expandedIcon : widget.collapsedIcon,
                color: widget.iconColor,
                size: widget.iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Table1DataModel tableModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (tableModel.data.isNotEmpty) {
              tableModel.removeRow();
              _updateTotalSum();
            }
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
            tableModel.addRow();
            _updateTotalSum();
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
    );
  }

  TableRow _buildTableHeaderRow(List<String> headers) {
    return TableRow(
      children: headers.map((header) {
        return Container(
          height: widget.rowHeight,
          alignment: Alignment.center,
          child: Text(
            header,
            style: TextStyles.bodyText4,
          ),
        );
      }).toList(),
    );
  }
}
