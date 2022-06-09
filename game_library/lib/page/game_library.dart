
import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/controller/data_controller.dart';

import '../services/fire_storage.dart';
import '../widget/game_list.dart';

class GameLibrary extends StatefulWidget {
  const GameLibrary({Key? key}) : super(key: key);

  @override
  State<GameLibrary> createState() => _GameLibraryState();
}

class _GameLibraryState extends State<GameLibrary> {
  late FireStorageServices _services;
  @override
  void initState() {
    super.initState();
    _services = FireStorageServices();
  }

  int gameCount = DataControl.allGame.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child: Text(
                  "Eklediğiniz oyunlar",
                  style: ConstantsStyles.newsTitle,
                ),
              ),
            ],
          ),
          Expanded(child: GameList(
            onDismis: (mygame) {
              setState(() {});
              _services.removeGame(mygame.id);
            },
          ))
        ],
      ),
    );
  }
}
