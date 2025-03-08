import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> educationProviders(Box settingsBox) async {
  final schoolEducationBox = await Hive.openBox<ItemTable1>('edu_school_education');
  final preschoolEducationBox = await Hive.openBox<ItemTable1>('edu_preschool_education');
  final universityEducationBox = await Hive.openBox<ItemTable1>('edu_university_education');
  final clubsSectionsBox = await Hive.openBox<ItemTable1>('edu_clubs_sections');
  final tutorsPrivateLessonsBox = await Hive.openBox<ItemTable1>('edu_tutors_private_lessons');
  final educationalAppsBox = await Hive.openBox<ItemTable1>('edu_educational_apps_subscriptions');
  final booksStudyMaterialsBox = await Hive.openBox<ItemTable1>('edu_books_study_materials');
  final workshopsTrainingBox = await Hive.openBox<ItemTable1>('edu_workshops_training');
  final educationalTripsBox = await Hive.openBox<ItemTable1>('edu_educational_trips');
  final additionalDevelopmentExpensesBox = await Hive.openBox<ItemTable1>('edu_additional_development_expenses');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(schoolEducationBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(preschoolEducationBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(universityEducationBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(clubsSectionsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(tutorsPrivateLessonsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(educationalAppsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(booksStudyMaterialsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(workshopsTrainingBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(educationalTripsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(additionalDevelopmentExpensesBox, settingsBox),
    ),
  ];
}
