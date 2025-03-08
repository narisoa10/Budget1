import 'package:flutter/material.dart';
import 'editable1_cell.dart';

class Table1Row extends StatelessWidget {
  final List<String> rowData;
  final double rowHeight;
  final ValueChanged<List<String>> onChanged;
  final TextStyle? textStyle;

  const Table1Row({
    super.key,
    required this.rowData,
    required this.rowHeight,
    required this.onChanged,
    this.textStyle,
  });

  TableRow toTableRow(int columnCount) {
    List<String> rowCells = List.from(rowData);
    if (rowCells.length < columnCount) {
      rowCells.addAll(List<String>.filled(columnCount - rowCells.length, ''));
    }

    return TableRow(
      children: rowCells.asMap().entries.map((entry) {
        int index = entry.key;
        String cellData = entry.value;

        if (index == rowCells.length - 1) {
          return Container(
            height: rowHeight,
            alignment: Alignment.center,
            child: Text(
              cellData,
              style: textStyle,
            ),
          );
        }

        TextInputType keyboardType = TextInputType.text;
        if (index == 1 || index == 2) {
          keyboardType = const TextInputType.numberWithOptions(decimal: true);
        }

        return Container(
          height: rowHeight,
          alignment: Alignment.center,
          child: Editable1Cell(
            initialValue: cellData,
            onChanged: (newValue) {
              List<String> updatedRow = List.from(rowData);
              updatedRow[index] = newValue;
              onChanged(updatedRow);
            },
            keyboardType: keyboardType,
            textStyle: textStyle,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
