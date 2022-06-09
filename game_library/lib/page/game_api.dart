import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/model/game_api_model.dart';

class GameApi extends StatefulWidget {
  const GameApi({Key? key}) : super(key: key);

  @override
  State<GameApi> createState() => _GameApiState();
}

class _GameApiState extends State<GameApi> {
  Future<List<GameApiModel>> _getGameList() async {
    try {
      var response = await Dio().get("https://www.freetogame.com/api/games");
      List<GameApiModel> _gameList = [];
      if (response.statusCode == 200) {
        var gameList = (response.data as List)
            .map((e) => GameApiModel.fromMap(e))
            .toList();

        return gameList;
      }
      return _gameList;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon:const Icon(Icons.search))],
        title: Text(
          "Games",
          style: ConstantsStyles.titleStyle,
        ),
      ),
      body: Center(
        child: FutureBuilder<List<GameApiModel>>(
          future: _getGameList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var gameApiList = snapshot.data!;

              return ListView.builder(
                itemCount: gameApiList.length,
                itemBuilder: (BuildContext context, int index) {
                  var game = gameApiList[index];

                  return Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.blue.shade100,
                          blurRadius: 20,
                          offset: const Offset(10, 10))
                    ]),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/gameApiDetail",
                            arguments: game);
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: Colors.blue.shade100, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.network(game.thumbnail),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                ListTile(
                                  title: Text(game.title + " - " + game.genre),
                                  subtitle: Text("Geliştirici : " +
                                      game.developer +
                                      "\n Yayıncı : " +
                                      game.publisher),
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
