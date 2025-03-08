import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/item_table1.dart';
import '../providers/table1_data_model.dart';

Future<List<ChangeNotifierProvider<Table1DataModel>>> transportProviders(Box settingsBox) async {
  final fuelBox = await Hive.openBox<ItemTable1>('transport_fuel');
  final maintenanceBox = await Hive.openBox<ItemTable1>('transport_maintenance');
  final parkingFeesBox = await Hive.openBox<ItemTable1>('transport_parking_fees');
  final tollRoadsBox = await Hive.openBox<ItemTable1>('transport_toll_roads');
  final publicTransportBox = await Hive.openBox<ItemTable1>('transport_public_transport');
  final taxiRidesharingBox = await Hive.openBox<ItemTable1>('transport_taxi_ridesharing');
  final carRentalBox = await Hive.openBox<ItemTable1>('transport_car_rental');
  final repairsBox = await Hive.openBox<ItemTable1>('transport_repairs');
  final miscellaneousBox = await Hive.openBox<ItemTable1>('transport_miscellaneous');

  return [
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(fuelBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(maintenanceBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(parkingFeesBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(tollRoadsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(publicTransportBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(taxiRidesharingBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(carRentalBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(repairsBox, settingsBox),
    ),
    ChangeNotifierProvider(
      create: (_) => Table1DataModel(miscellaneousBox, settingsBox),
    ),
  ];
}
