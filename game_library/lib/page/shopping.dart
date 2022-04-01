import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/controller/data_controller.dart';
import 'package:game_library/datasource/game_about_source.dart';
import 'package:game_library/model/game_shop_model.dart';

class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  double totalMoney = DataControl.gamesMoney();

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
          Text("Toplam fiyat : ${totalMoney.toStringAsFixed(2)}  "),
          PopupWidget(),
          Text(" " + DataControl.shopGame.length.toString())
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
          if (DataControl.shopGame.isNotEmpty) {
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
          /* ListTile(
            title: Text(
              GameAboutSource.GAME_NAME[index],
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                GameAboutSource.GAME_MONEY[index].toString() + " tl",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),*/

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
              // Text(DataControl.count[index].toString()),
              IconButton(
                  onPressed: () {
                    setState(() {});
                    //DataControl.count[index]++;

                    GameShopModel newProduct = GameShopModel(
                        GameAboutSource.gameName[index],
                        GameAboutSource.gameMoney[index]);
                    DataControl.addGameShopList(newProduct);
                    totalMoney = DataControl.gamesMoney();
                  },
                  icon: const Icon(Icons.add_box)),
              IconButton(
                  onPressed: () {
                    setState(() {});
                    // if (DataControl.count[index] != 0)
                    //DataControl.count[index]--;
                    /* else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Ürün Zaten yok")));
                    }*/
                    DataControl.removeGameShopList(
                        GameAboutSource.gameName[index]);
                    totalMoney = DataControl.gamesMoney();
                  },
                  icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}

class PopupWidget extends StatefulWidget {
  const PopupWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  @override
  Widget build(BuildContext context) {
    return DataControl.shopGame.isNotEmpty
        ? PopupMenuButton(
            color: Colors.blue.shade600,
            icon: const Icon(Icons.add_shopping_cart),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            itemBuilder: (context) {
              return DataControl.shopGame
                  .map((e) => PopupMenuItem(
                      textStyle:
                          const TextStyle(decoration: TextDecoration.underline),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(e.name),
                              Text(" " + e.money.toString()),
                            ],
                          ),
                        ],
                      )))
                  .toList();
            })
        : const Text(" Ürün yok  ");
  }
}
