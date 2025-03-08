import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_model.dart';
import '../localization/localization.dart';
import '../app.dart';

class SettingsPage extends StatelessWidget {
  final List<String> languages = ['en', 'de', 'fr', 'it', 'es', 'pt', 'pl', 'uk', 'ru'];
  final List<String> currencies = ['€', '\$', 'C\$', '₴', '£', '₽', 'zł'];

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var settingsModel = Provider.of<SettingsModel>(context); // Получаем модель настроек

    final TextEditingController warningController = TextEditingController(
      text: settingsModel.warningThreshold.toString(),
    );
    final TextEditingController criticalController = TextEditingController(
      text: settingsModel.criticalThreshold.toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.getTranslation('settings')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Выбор языка
            Text(Localization.getTranslation('selectLanguage'), style: const TextStyle(fontSize: 14)),
            DropdownButton<String>(
              value: settingsModel.selectedLanguage,
              items: languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  settingsModel.setLanguage(newValue); // Обновляем язык
                  App.of(context)?.setLocale(Locale(newValue)); // Меняем язык приложения
                }
              },
            ),
            const SizedBox(height: 16),

            // Выбор валюты
            Text(Localization.getTranslation('selectCurrency'), style: const TextStyle(fontSize: 14)),
            DropdownButton<String>(
              value: settingsModel.selectedCurrency,
              items: currencies.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  settingsModel.setCurrency(newValue); // Обновляем валюту
                }
              },
            ),
            const SizedBox(height: 16),

            // Установка порогов
            Text(
              '${Localization.getTranslation('threshold_warning')} (%)',
              style: const TextStyle(fontSize: 14),
            ),
            TextField(
              controller: warningController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '${Localization.getTranslation('enter_threshold_warning')} (%)',
              ),
              onSubmitted: (value) {
                double? threshold = double.tryParse(value);
                if (threshold != null) {
                  settingsModel.updateThresholds(
                    warning: threshold,
                    critical: settingsModel.criticalThreshold,
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            Text(
              '${Localization.getTranslation('threshold_critical')} (%)',
              style: const TextStyle(fontSize: 14),
            ),
            TextField(
              controller: criticalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '${Localization.getTranslation('enter_threshold_critical')} (%)',
              ),
              onSubmitted: (value) {
                double? threshold = double.tryParse(value);
                if (threshold != null) {
                  settingsModel.updateThresholds(
                    warning: settingsModel.warningThreshold,
                    critical: threshold,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
