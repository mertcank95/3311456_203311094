import 'package:flutter/material.dart';
import 'package:game_library/datasource/game_about_source.dart';
import 'package:game_library/model/game_about_model.dart';
import 'package:game_library/widget/game_about_item.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class GameAbout extends StatefulWidget {
  //const GameAbout({Key? key}) : super(key: key);
  late List<GameAboutModel> gameAbout;
  List<GameAboutModel> items = [];
  GameAbout({Key? key}) : super(key: key);
  @override
  State<GameAbout> createState() => _GameAboutState();
}

class _GameAboutState extends State<GameAbout> {
  @override
  void initState() {
    super.initState();
    widget.items.addAll(gameAboutData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ConstantsStyles.appBarColor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "ara",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
              onChanged: (value) {
                setState(() {
                  filterSearchResults(value.toLowerCase());
                });
              },
            ),
          )),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return GameAboutItem(selectGameAbout: widget.items[index]);
          }),
    );
  }

  void filterSearchResults(
    String query,
  ) {
    List<GameAboutModel> dummySearchList = [];
    dummySearchList.addAll(gameAboutData());
    if (query.isNotEmpty) {
      List<GameAboutModel> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.gameName.toString().toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        widget.items.clear();
        widget.items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        widget.items.clear();
        widget.items.addAll(gameAboutData());
      });
    }
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
