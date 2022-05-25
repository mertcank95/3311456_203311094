import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
part 'game_shop_model.g.dart';

@HiveType(typeId: 1)
class GameShopModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double money;

  GameShopModel(this.id, this.name, this.money);

  factory GameShopModel.create({required String name, required double money}) {
    return GameShopModel(const Uuid().v1(), name, money);
  }


  
}
