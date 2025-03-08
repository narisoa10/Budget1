import 'package:flutter/material.dart';
import '../widgets/category_button_grid.dart';
import '../localization/localization.dart';

class CategoryPage extends StatelessWidget {
  final String selectedCurrency;  // Параметр для выбранной валюты

  const CategoryPage({
    super.key,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    // Загружаем локализацию при старте страницы
    Localization.load(Localizations.localeOf(context));
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CategoryButtonGrid(
          selectedCurrency: selectedCurrency,  // Передаем выбранную валюту в CategoryButtonGrid
        ),
      ),
    );
  }
}
