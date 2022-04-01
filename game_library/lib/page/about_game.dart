import 'package:flutter/material.dart';
import 'package:game_library/datasource/game_about_source.dart';
import 'package:game_library/model/game_about_model.dart';
import 'package:game_library/widget/game_about_item.dart';

import '../constants/constants.dart';

class GameAbout extends StatelessWidget {
  //const GameAbout({Key? key}) : super(key: key);
  late List<GameAboutModel> gameAbout;
  GameAbout() {
    gameAbout = gameAboutData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsStyles.appBarColor,
        title: Text(
          "Oyun Bilgileri",
          style: ConstantsStyles.titleStyle,
        ),
      ),
      body: ListView.builder(
          itemCount: gameAbout.length,
          itemBuilder: (context, index) {
            return GameAboutItem(selectGameAbout: gameAbout[index]);
          }),
    );
  }

  List<GameAboutModel> gameAboutData() {
    List<GameAboutModel> temp = [];
    for (var i = 0; i < 9; i++) {
      String gameIcon = GameAboutSource.gameName[i] + "_icon.png";
      String gameImage = GameAboutSource.gameName[i] + ".png";
      GameAboutModel newGame = GameAboutModel(
          GameAboutSource.gameName[i],
          GameAboutSource.gameDate[i],
          GameAboutSource.gameContent[i],
          gameIcon,
          gameImage);
      temp.add(newGame);
    }
    return temp;
  }
}
