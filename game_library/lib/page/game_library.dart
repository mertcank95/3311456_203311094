import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/controller/data_controller.dart';
import 'package:game_library/widget/game_list.dart';

class GameLibrary extends StatefulWidget {
  const GameLibrary({Key? key}) : super(key: key);

  @override
  State<GameLibrary> createState() => _GameLibraryState();
}

class _GameLibraryState extends State<GameLibrary> {
  int gameCount = DataControl.allGame.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ConstantsStyles.appBarColor,
          title: Text(
            "Oyunlarınız",
            style: ConstantsStyles.titleStyle,
          )),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text(
                  "Eklediğiniz oyunlar",
                  style: ConstantsStyles.newsTitle,
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text(
                  gameCount.toString(),
                  style: ConstantsStyles.newsTitle,
                )),
              )
            ],
          ),
          Expanded(child: Container(
            child: GameList(onDismis: (index) {
              DataControl.allGame.removeAt(index);
              setState(() {
                gameCount = DataControl.allGame.length;
              });
            }),
          ))
        ],
      ),
    );
  }
}
