import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> healthProviders(Box settingsBox) async {
  // Открываем боксы для каждой из объединенных категорий
  final medicationsPharmacyProductsBox = await Hive.openBox<ItemTable1>('med_medications_pharmacy_products');
  final doctorVisitsExaminationsBox = await Hive.openBox<ItemTable1>('med_doctor_visits_examinations');
  final treatmentsChronicConditionsBox = await Hive.openBox<ItemTable1>('med_treatments_chronic_conditions');
  final dentistryOptometryBox = await Hive.openBox<ItemTable1>('med_dentistry_optometry');
  final physicalTherapyOrthopedicServicesBox = await Hive.openBox<ItemTable1>('med_physical_therapy_orthopedic_services');
  final psychologicalCosmeticServicesBox = await Hive.openBox<ItemTable1>('med_psychological_cosmetic_services');
  final emergencyVaccinationBox = await Hive.openBox<ItemTable1>('med_emergency_vaccination');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(medicationsPharmacyProductsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(doctorVisitsExaminationsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(treatmentsChronicConditionsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(dentistryOptometryBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(physicalTherapyOrthopedicServicesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(psychologicalCosmeticServicesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(emergencyVaccinationBox, settingsBox),
    ),
  ];
}
