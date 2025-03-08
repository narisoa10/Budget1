import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> entertainmentProviders(Box settingsBox) async {
  final moviesTheatersBox = await Hive.openBox<ItemTable1>('leisure_movies_theaters');
  final museumsExhibitionsBox = await Hive.openBox<ItemTable1>('leisure_museums_exhibitions');
  final sportsMusicEventsBox = await Hive.openBox<ItemTable1>('leisure_sports_music_events');
  final summerCampsCampingBox = await Hive.openBox<ItemTable1>('leisure_summer_camps_camping');
  final hikingTripsBox = await Hive.openBox<ItemTable1>('leisure_hiking_trips');
  final homePartiesBox = await Hive.openBox<ItemTable1>('leisure_home_parties');
  final hobbiesCraftsBox = await Hive.openBox<ItemTable1>('leisure_hobbies_crafts');
  final cafesRestaurantsBox = await Hive.openBox<ItemTable1>('leisure_cafes_restaurants');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(moviesTheatersBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(museumsExhibitionsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(sportsMusicEventsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(summerCampsCampingBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(hikingTripsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(homePartiesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(hobbiesCraftsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(cafesRestaurantsBox, settingsBox),
    ),
  ];
}
