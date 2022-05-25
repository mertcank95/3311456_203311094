// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_shop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameShopModelAdapter extends TypeAdapter<GameShopModel> {
  @override
  final int typeId = 1;

  @override
  GameShopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameShopModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, GameShopModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.money);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameShopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
