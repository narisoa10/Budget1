import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:budget1/generated/intl/messages_all.dart';  // Подключаем сгенерированные локализации

class Localization {
  // Список поддерживаемых языков
  static const supportedLocales = [
    Locale('en', ''),
    Locale('de', ''),
    Locale('fr', ''),
    Locale('it', ''),
    Locale('es', ''),
    Locale('pt', ''),
    Locale('pl', ''),
    Locale('uk', ''),
    Locale('ru', ''),
  ];

  // Делегаты локализаций
  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Логика выбора языка
  static Locale? localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode) {
        return supportedLocale;
      }
    }
    return const Locale('en', '');  // Английский по умолчанию
  }

  // Метод для загрузки локализованных строк
  static Future<void> load(Locale locale) async {
    final String name = locale.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    await initializeMessages(localeName);  // Загружаем переводы для выбранной локали
    Intl.defaultLocale = localeName;  // Устанавливаем локаль по умолчанию
  }

  // Метод для получения локализованных строк
  static String getTranslation(String key) {
    return Intl.message(
      key,
      name: key,
    );
  }
}
