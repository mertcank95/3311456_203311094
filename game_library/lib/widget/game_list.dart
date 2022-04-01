import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/controller/data_controller.dart';
import 'package:game_library/model/game_model.dart';

class GameList extends StatefulWidget {
  final Function onDismis;

  const GameList({required this.onDismis, Key? key}) : super(key: key);

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  @override
  Widget build(BuildContext context) {
    List<GameModel> allGameList = DataControl.allGame;

    return allGameList.isNotEmpty
        ? ListView.builder(
            itemCount: allGameList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                onDismissed: (direction) {
                  widget.onDismis(index);
                },
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: newCard(allGameList, index),
                ),
              );
            },
          )
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lütfen Önce Oyun Ekleyiniz",
                style: ConstantsStyles.textStyle,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/gameAddLibrary");
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Oyun Ekle"))
            ],
          ));
  }

  Card newCard(List<GameModel> allGameList, int index) {
    return Card(
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(color: Colors.blue.shade100, width: 2)),
        child: ListTile(
            trailing: Text(allGameList[index].gameType),
            leading: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Text(
                  allGameList[index].gameDate,
                  textAlign: TextAlign.center,
                )),
            subtitle: Text(allGameList[index].gameContent),
            title: Text(
              allGameList[index].gameName,
              style: ConstantsStyles.newsTitle,
            )));
  }
}
