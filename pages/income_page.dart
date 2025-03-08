import 'package:flutter/material.dart';
import '../widgets/tables/table0/table0.dart';

class IncomePage extends StatefulWidget {
  final String selectedCurrency;

  const IncomePage({super.key, required this.selectedCurrency});

  @override
  IncomePageState createState() => IncomePageState();
}

class IncomePageState extends State<IncomePage> {
  double totalIncome = 0.0;

  // Функция для обновления общей суммы доходов
  void _updateIncome(double newTotalIncome) {
    setState(() {
      totalIncome = newTotalIncome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20), // Отступ между AppBar и таблицей
            Table0(
              onIncomeUpdated: _updateIncome, // Передаем функцию обновления доходов в Table0
            ),
          ],
        ),
      ),
    );
  }
}
