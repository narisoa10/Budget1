import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_model.dart';
import '../localization/localization.dart';
import '../pages/home_page.dart';
import '../pages/categories/charity_page.dart';
import '../pages/categories/debt_page.dart';
import '../pages/categories/education_page.dart';
import '../pages/categories/entertainment_page.dart';
import '../pages/categories/food_page.dart';
import '../pages/categories/health_page.dart';
import '../pages/categories/housing_page.dart';
import '../pages/categories/insurance_page.dart';
import '../pages/categories/miscellaneous_page.dart';
import '../pages/categories/transport_page.dart';
import '../pages/categories/clothing_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();

  static AppState? of(BuildContext context) => context.findAncestorStateOfType<AppState>();
}

class AppState extends State<App> {
  void setLocale(Locale locale) {
    Localization.load(locale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settingsModel, child) {
        Locale locale = Locale(settingsModel.selectedLanguage);
        String currency = settingsModel.selectedCurrency;

        return MaterialApp(
          title: 'Budget1',
          theme: ThemeData(
            fontFamily: 'Inter',
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          locale: locale,
          supportedLocales: Localization.supportedLocales,
          localizationsDelegates: Localization.localizationsDelegates,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            if (deviceLocale != null) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale.languageCode) {
                  return deviceLocale;
                }
              }
            }
            return const Locale('en');
          },
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(currency: currency),
            '/food': (context) => FoodPage(selectedCurrency: currency),
            '/housing': (context) => HousingPage(selectedCurrency: currency),
            '/transport': (context) => TransportPage(selectedCurrency: currency),
            '/health': (context) => HealthPage(selectedCurrency: currency),
            '/clothing': (context) => ClothingPage(selectedCurrency: currency),
            '/education': (context) => EducationPage(selectedCurrency: currency),
            '/entertainment': (context) => EntertainmentPage(selectedCurrency: currency),
            '/insurance': (context) => InsurancePage(selectedCurrency: currency),
            '/miscellaneous': (context) => MiscellaneousPage(selectedCurrency: currency),
            '/debt': (context) => DebtPage(selectedCurrency: currency),
            '/charity': (context) => CharityPage(selectedCurrency: currency),
          },
        );
      },
    );
  }
}
