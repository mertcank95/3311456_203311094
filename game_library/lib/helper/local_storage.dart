import 'package:game_library/model/game_shop_model.dart';

abstract class LocalStorage {
  Future<void> addGame({required GameShopModel game});
  Future<List<GameShopModel>> getAllGame();
  Future<bool> deleteGame({required GameShopModel game});
}
