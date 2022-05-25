import 'package:game_library/helper/local_storage.dart';
import 'package:game_library/model/game_shop_model.dart';
import 'package:hive/hive.dart';

class HiveStorage extends LocalStorage {
  late Box<GameShopModel> _gameBox;
  HiveStorage() {
    _gameBox = Hive.box<GameShopModel>("game");
  }

  @override
  Future<void> addGame({required GameShopModel game}) async {
    await _gameBox.put(game.id, game);
  }

  @override
  Future<bool> deleteGame({required GameShopModel game}) async {
    _gameBox.delete(game.id);
    return true;
  }

  @override
  Future<List<GameShopModel>> getAllGame() async {
    List<GameShopModel> _allGame = _gameBox.values.toList();

    return _allGame;
  }

  double sumMoney() {
    double money = 0;
    List<GameShopModel> _allGame = _gameBox.values.toList();
    for (var element in _allGame) {
      money += element.money;
    }

    return money;
  }

  Future<void> clearHive() async {
    await _gameBox.clear();
  }
}
