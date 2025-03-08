import 'package:hive/hive.dart';

part 'item_table1.g.dart';

@HiveType(typeId: 0)
class ItemTable1 extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double pricePerUnit;

  @HiveField(2)
  double quantity;

  @HiveField(3)
  double total;

  ItemTable1({
    required this.name,
    required this.pricePerUnit,
    required this.quantity,
    required this.total,
  });

  // Метод copyWith для создания новой копии объекта с измененными значениями
  ItemTable1 copyWith({
    String? name,
    double? pricePerUnit,
    double? quantity,
    double? total,
  }) {
    return ItemTable1(
      name: name ?? this.name,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
    );
  }
}
