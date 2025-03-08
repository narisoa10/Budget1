import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../../localization/localization.dart';
import '../../providers/settings_model.dart';

class TotalContainer extends StatelessWidget {
  final String selectedCurrency;
  final String categoryName; // Название категории
  final bool showBackArrow;

  const TotalContainer({
    super.key,
    required this.selectedCurrency,
    required this.categoryName,
    this.showBackArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final settingsModel = Provider.of<SettingsModel>(context);
    final categoryData = settingsModel.categoryData[categoryName];

    final double totalExpense = categoryData?['totalExpense'] ?? 0.0;
    final DateTime? lastUpdated = categoryData?['lastUpdated'];
    final String lastUpdatedText = lastUpdated != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(lastUpdated)
        : Localization.getTranslation('no_updates');

    String totalText = Localization.getTranslation('total');

    // Определяем, тёмный или светлый фон, и подбираем подходящий цвет текста и иконок
    final bool isDarkBackground = ThemeData.estimateBrightnessForColor(AppColors.subcategoryAppBarColor) == Brightness.dark;
    final Color iconAndTextColor = (isDarkBackground ? Colors.white : Colors.black).withOpacity(0.7);

    return Container(
      color: AppColors.subcategoryAppBarColor,
      child: SingleChildScrollView( // Добавляем прокрутку для предотвращения переполнения
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Стрелка назад, если `showBackArrow` установлено в `true`
                  if (showBackArrow)
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.arrow_back,
                        color: iconAndTextColor,
                        size: 30.0,
                      ),
                    ),
                  if (showBackArrow) const SizedBox(width: 8), // Отступ между стрелкой и текстом

                  // Текст "total" и сумма с валютой в одном ряду
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalText: ',
                          style: TextStyles.bodyText7.copyWith(color: iconAndTextColor),
                        ),
                        Text(
                          '${totalExpense.toStringAsFixed(2)} $selectedCurrency',
                          style: TextStyles.appBarTextStyle1.copyWith(
                            color: iconAndTextColor,
                            fontWeight: FontWeight.bold, // Жирный шрифт для суммы и валюты
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Дата последнего обновления
              Text(
                '${Localization.getTranslation('last_updated')}: $lastUpdatedText',
                style: TextStyles.bodyText8.copyWith(color: iconAndTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
