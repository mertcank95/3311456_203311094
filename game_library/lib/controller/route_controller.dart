import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_library/main.dart';

import 'package:game_library/model/game_about_model.dart';
import 'package:game_library/model/game_api_model.dart';
import 'package:game_library/page/about.dart';
import 'package:game_library/page/about_game.dart';
import 'package:game_library/page/about_game_detail.dart';
import 'package:game_library/page/game_add_library.dart';
import 'package:game_library/page/game_api.dart';
import 'package:game_library/page/game_api_detail.dart';
import 'package:game_library/page/game_engine.dart';
import 'package:game_library/page/game_library.dart';
import 'package:game_library/page/game_post.dart';

import 'package:game_library/page/home.dart';
import 'package:game_library/page/image_detail.dart';
import 'package:game_library/page/mypost.dart';
import 'package:game_library/page/personal_data.dart';
import 'package:game_library/page/quastion_game.dart';
import 'package:game_library/page/shopping_complate.dart';
import 'package:game_library/page/shopping.dart';
import 'package:game_library/page/shopping_history.dart';

import '../page/game_news.dart';

class RouteControl {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _gotoPage(const MainPage(), settings);
      case '/gamenews':
        return _gotoPage(const GameNews(), settings);
      case '/home':
        return _gotoPage(const Home(), settings);
      case '/gameAbout':
        return _gotoPage(GameAbout(), settings);
      case '/gameAboutDetail':
        return _gotoPage(
            GameAboutDetail(
                selectedGameAbout: settings.arguments as GameAboutModel),
            settings);
      case '/about':
        return _gotoPage(const About(), settings);
      case '/quastionGame':
        return _gotoPage(const QuastionGame(), settings);
      case '/personalData':
        return _gotoPage(const PersonalData(), settings);
      case '/gameAddLibrary':
        return _gotoPage(const GameAddLibrary(), settings);
      case '/gameLibrary':
        return _gotoPage(const GameLibrary(), settings);
      case '/gameEngine':
        return _gotoPage(const GameEngine(), settings);
      case '/shopping':
        return _gotoPage(const Shopping(), settings);
      case '/shoppingComplate':
        return _gotoPage(const ShoppingComplate(), settings);
      case '/gameApi':
        return _gotoPage(const GameApi(), settings);
      case '/imageDetail':
        return _gotoPage(
            ImageDetail(imagePath: settings.arguments as String), settings);
      case '/gameApiDetail':
        return _gotoPage(
            GameApiDetail(game: settings.arguments as GameApiModel), settings);
      case '/gamePost':
        return _gotoPage(const GamePost(), settings);
      case '/shoppingHistory':
        return _gotoPage(const ShopingHistory(), settings);
      case '/myPost':
        return _gotoPage(const MyGamePost(), settings);
    }
    return null;
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
