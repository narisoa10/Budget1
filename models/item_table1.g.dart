// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_table1.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemTable1Adapter extends TypeAdapter<ItemTable1> {
  @override
  final int typeId = 0;

  @override
  ItemTable1 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemTable1(
      name: fields[0] as String,
      pricePerUnit: fields[1] as double,
      quantity: fields[2] as double,
      total: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ItemTable1 obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.pricePerUnit)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTable1Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
