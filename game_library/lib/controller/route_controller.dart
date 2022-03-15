import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_library/main.dart';
import 'package:game_library/model/game_about_model.dart';
import 'package:game_library/page/about.dart';
import 'package:game_library/page/about_game.dart';
import 'package:game_library/page/about_game_detail.dart';
import 'package:game_library/page/game_add_library.dart';
import 'package:game_library/page/game_engine.dart';
import 'package:game_library/page/game_library.dart';
import 'package:game_library/page/gamenews.dart';
import 'package:game_library/page/personal_data.dart';
import 'package:game_library/page/quastion_game.dart';
import 'package:game_library/page/shopping_complate.dart';
import 'package:game_library/page/shopping.dart';

class RouteControl {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _gotoPage(MainPage(), settings);
      case '/gamenews':
        return _gotoPage(GameNews(), settings);
      case '/gameAbout':
        return _gotoPage(GameAbout(), settings);
      case '/gameAboutDetail':
        return _gotoPage(
            GameAboutDetail(
                selectedGameAbout: settings.arguments as GameAboutModel),
            settings);
      case '/about':
        return _gotoPage(About(), settings);
      case '/quastionGame':
        return _gotoPage(QuastionGame(), settings);
      case '/personalData':
        return _gotoPage(PersonalData(), settings);
      case '/gameAddLibrary':
        return _gotoPage(GameAddLibrary(), settings);
      case '/gameLibrary':
        return _gotoPage(GameLibrary(), settings);
      case '/gameEngine':
        return _gotoPage(GameEngine(), settings);
      case '/shopping':
        return _gotoPage(Shopping(), settings);
      case '/shoppingComplate':
        return _gotoPage(ShoppingComplate(), settings);
    }
  }

  static Route<dynamic>? _gotoPage(Widget page, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          builder: ((context) => page), settings: settings);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
          builder: ((context) => page), settings: settings);
    } else {
      return CupertinoPageRoute(
          builder: ((context) => page), settings: settings);
    }
  }
}
