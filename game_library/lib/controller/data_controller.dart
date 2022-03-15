import 'package:flutter/material.dart';
import 'package:game_library/model/game_model.dart';
import 'package:game_library/model/game_shop_model.dart';

import '../datasource/game_about_source.dart';

class DataControl {
  static List<String> _gameType() {
    return ["Aksiyon", "Macera", "Rol yapma", "Savaş", "Strateji"];
  }

  static List<DropdownMenuItem<String>> gameTypeDropDown() {
    return _gameType()
        .map(
          (e) => DropdownMenuItem(
            child: Text(e),
            value: e,
          ),
        )
        .toList();
  }

  static List<GameModel> allGame = [];
  static gameAdd(GameModel game) {
    allGame.add(game);
  }

  static List<GameShopModel> shopGame = [];

  static addGameShopList(GameShopModel gameShop) {
    shopGame.add(gameShop);
  }

  static removeGameShopList(String gameName) {
    for (int i = 0; i < shopGame.length; i++) {
      if (shopGame[i].name == gameName) {
        shopGame.removeAt(i);
        break;
      }
    }
  }

  static gameShopListRemove() {
    if (shopGame.length > 0) shopGame.clear();
  }

  static double gamesMoney() {
    double money = 0;
    for (int i = 0; i < shopGame.length; i++) {
      money += shopGame[i].money;
    }
    return money;
  }

  static List<int> count = List.filled(GameAboutSource.GAME_NAME.length, 0);

  static resetList() {
    for (var item in DataControl.count) {
      item = 0;
    }
  }
}
