import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/datasource/game_about_source.dart';
import 'package:game_library/model/game_shop_model.dart';
import 'package:game_library/services/hive_storage.dart';

double _totalMoney = 0;

class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  late HiveStorage _hive;
  late List<GameShopModel> _allGame;

  @override
  void initState() {
    super.initState();
    _hive = HiveStorage();
    _allGame = [];
    _getAllGames();
    _totalMoney = _hive.sumMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "oyun listesi",
          style: ConstantsStyles.titleStyle,
        ),
        backgroundColor: ConstantsStyles.appBarColor,
        actions: [
          PopupWidget(
            gameList: _allGame,
            hive: _hive,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
        ),
        itemCount: GameAboutSource.gameName.length,
        itemBuilder: (BuildContext context, int index) {
          return cardMethod(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_allGame.isNotEmpty) {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/shoppingComplate");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("Alışverişi tamamlamak için satın alma yapınız")));
          }
        },
        child: const Icon(Icons.card_giftcard),
      ),
    );
  }

  Widget cardMethod(int index) {
    return Card(
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Image.asset(
            "assets/images/${GameAboutSource.gameName[index]}_icon.png",
            width: 75,
            height: 75,
          ),
          Text(
            GameAboutSource.gameName[index],
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Text(GameAboutSource.gameMoney[index].toString() + " tl",
              style: const TextStyle(fontSize: 20, color: Colors.black38)),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () async {
                    setState(() {});

                    var newGame = GameShopModel.create(
                        name: GameAboutSource.gameName[index],
                        money: GameAboutSource.gameMoney[index]);
                    _allGame.insert(0, newGame);
                    await _hive.addGame(game: newGame);
                    _totalMoney = _hive.sumMoney();
                  },
                  icon: const Icon(Icons.add_box)),
            ],
          )
        ],
      ),
    );
  }

  void _getAllGames() async {
    _allGame = await _hive.getAllGame();
    setState(() {});
  }
}

class PopupWidget extends StatefulWidget {
  final HiveStorage hive;
  List<GameShopModel> gameList;

  PopupWidget({Key? key, required this.hive, required this.gameList})
      : super(key: key);

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  @override
  void initState() {
  
    super.initState();
    _totalMoney = widget.hive.sumMoney();
  }

  @override
  Widget build(BuildContext context) {
    return widget.gameList.isNotEmpty
        ? Row(
            children: [
              Text("Fiyat : " + _totalMoney.toString()),
              PopupMenuButton(
                  color: Colors.blue.shade600,
                  icon: const Icon(Icons.add_shopping_cart),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  itemBuilder: (context) {
                    return widget.gameList
                        .map((e) => PopupMenuItem(
                            textStyle: const TextStyle(
                                decoration: TextDecoration.underline),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(e.name),
                                    Text(" " + e.money.toString()),
                                    IconButton(
                                        onPressed: () {
                                          widget.gameList.remove(e);

                                          widget.hive.deleteGame(game: e);
                                          _totalMoney = widget.hive.sumMoney();
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        icon:const Icon(Icons.delete))
                                  ],
                                ),
                              ],
                            )))
                        .toList();
                  }),
              Text(widget.gameList.length.toString())
            ],
          )
        : const Text(" Ürün yok  ");
  }
}
