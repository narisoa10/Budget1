import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'models/item_table1.dart';
import 'providers/settings_model.dart';
import 'providers/category_model.dart';

// Импортируем провайдеры для разных страниц
import 'providers/housing_providers.dart';
import 'providers/food_providers.dart';
import 'providers/transport_providers.dart';
import 'providers/health_providers.dart';
import 'providers/clothing_providers.dart';
import 'providers/education_providers.dart';
import 'providers/entertainment_providers.dart';
import 'providers/insurance_providers.dart';
import 'providers/miscellaneous_providers.dart';
import 'providers/debt_providers.dart';
import 'providers/charity_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ItemTable1Adapter());

  // Open settings and category boxes
  final settingsBox = await Hive.openBox('settings');
  final categoryBox = await Hive.openBox('category_data');

  // Инициализация провайдеров для различных страниц
  final housingProviderInstances = await housingProviders(settingsBox);
  final foodProviderInstances = await foodProviders(settingsBox);
  final transportProviderInstances = await transportProviders(settingsBox);
  final healthProviderInstances = await healthProviders(settingsBox);
  final clothingProviderInstances = await clothingProviders(settingsBox);
  final educationProviderInstances = await educationProviders(settingsBox);
  final entertainmentProviderInstances = await entertainmentProviders(settingsBox);
  final insuranceProviderInstances = await insuranceProviders(settingsBox);
  final miscellaneousProviderInstances = await miscellaneousProviders(settingsBox);
  final debtProviderInstances = await debtProviders(settingsBox);
  final charityProviderInstances = await charityProviders(settingsBox);

  runApp(
    MultiProvider(
      providers: [
        ...housingProviderInstances,
        ...foodProviderInstances,
        ...transportProviderInstances,
        ...healthProviderInstances,
        ...clothingProviderInstances,
        ...educationProviderInstances,
        ...entertainmentProviderInstances,
        ...insuranceProviderInstances,
        ...miscellaneousProviderInstances,
        ...debtProviderInstances,
        ...charityProviderInstances,
        ChangeNotifierProvider(
          create: (_) => SettingsModel(settingsBox),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryModel( categoryBox),
        ),
      ],
      child: const App(),
    ),
  );
}
