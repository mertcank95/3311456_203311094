import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/model/game_api_model.dart';

class GameApiDetail extends StatelessWidget {
  final GameApiModel game;
  const GameApiDetail({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Game detay",
          style: ConstantsStyles.titleStyle,
        ),
        backgroundColor: ConstantsStyles.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(children: [
              Image.network(game.thumbnail),
              Text(
                game.title,
                style: ConstantsStyles.newsTitle,
              ),
              Text(game.genre + " - " + game.platform),
              Text(game.developer + " - " + game.publisher),
              Text(game.releaseDate.day.toString() +
                  "." +
                  game.releaseDate.month.toString() +
                  "." +
                  game.releaseDate.year.toString()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: Text(
                  game.shortDescription,
                  style: const TextStyle(fontSize: 20),
                )),
              ),
              GestureDetector(
                child: Text(
                  game.freetogameProfileUrl,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
