import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> clothingProviders(Box settingsBox) async {
  final adultClothingBox = await Hive.openBox<ItemTable1>('cloth_clothing');
  final footwearBox = await Hive.openBox<ItemTable1>('cloth_footwear');
  final hairSalonsBox = await Hive.openBox<ItemTable1>('cloth_hair_salons');
  final cosmeticsSkincareBox = await Hive.openBox<ItemTable1>('cloth_cosmetics_skincare');
  final personalHygieneBox = await Hive.openBox<ItemTable1>('cloth_personal_hygiene');
  final paidAppsBox = await Hive.openBox<ItemTable1>('cloth_paid_apps_subscriptions');
  final fitnessBodyCareBox = await Hive.openBox<ItemTable1>('cloth_fitness_body_care');
  final mobileInternetBox = await Hive.openBox<ItemTable1>('cloth_mobile_internet');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(adultClothingBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(footwearBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(hairSalonsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(cosmeticsSkincareBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(personalHygieneBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(paidAppsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(fitnessBodyCareBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(mobileInternetBox, settingsBox),
    ),
  ];
}
