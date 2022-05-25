import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/model/shop_fire_model.dart';
import 'package:game_library/services/fire_storage.dart';

import '../model/game_shop_model.dart';
import '../services/hive_storage.dart';

class ShoppingComplate extends StatefulWidget {
  const ShoppingComplate({Key? key}) : super(key: key);

  @override
  State<ShoppingComplate> createState() => _ShoppingComplateState();
}

class _ShoppingComplateState extends State<ShoppingComplate> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late HiveStorage _hive;
  late List<GameShopModel> _allGame;
  late FireStorageServices services;
  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _hive = HiveStorage();
    _allGame = [];
    _getAllGames();
    services = FireStorageServices();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Kart işlemleri",
          style: ConstantsStyles.titleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              child: ListView.builder(
                itemCount: _allGame.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Text(
                            _allGame[index].name +
                                "  " +
                                _allGame[index].money.toString(),
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () {
                                setState(() {});
                                _hive.deleteGame(game: _allGame[index]);
                                _allGame.remove(_allGame[index]);
                                if (_allGame.isEmpty) {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Icon(
                                Icons.delete_forever,
                                size: 25,
                              )),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Text(
              "Toplam : " + _hive.sumMoney().toStringAsFixed(2) + " TL",
              style: ConstantsStyles.newsTitle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Kredi Kartı bilgileri",
                          style: TextStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        textFormFieldMethod(
                            TextInputType.number,
                            const Icon(Icons.ballot_sharp),
                            "**** / **** / **** / ****",
                            prefixText: "TR ",
                            labelText: "Kredi kartı numaranız"),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(
                                      TextInputType.text,
                                      const Icon(Icons.account_circle),
                                      "Adınız",
                                      labelText: "Adınız")),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(
                                      TextInputType.text,
                                      const Icon(Icons.account_circle),
                                      "Soy adınız",
                                      labelText: "Soy adınız")),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(
                                      TextInputType.number,
                                      const Icon(Icons.calendar_today_sharp),
                                      "--/--",
                                      labelText: "Tarih")),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(
                                      TextInputType.number,
                                      const Icon(Icons.bento),
                                      "---",
                                      labelText: "Güvenlik")),
                            )
                          ],
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _hive.clearHive();
                                List<String> gameNames = [];
                                Map<String, String> gameNameMoney = {};
                                for (var element in _allGame) {
                                  gameNames.add(element.name);
                                  gameNameMoney[element.name] =
                                      element.money.toString();
                                }
                                try {
                                  ShopFireModel newShop = ShopFireModel(
                                      games: gameNameMoney,
                                      totalMoney: _hive.sumMoney().toString(),
                                      userId: _auth.currentUser!.uid);
                                  services.addShopList(newShop);
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Alışverişiniz tamamlandı")));
                              }
                            },
                            icon: const Icon(Icons.card_giftcard),
                            label: const Text("ödemeyi tamamla")),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField textFormFieldMethod(
      TextInputType type, Icon textIcon, String hint,
      {String prefixText = "", String labelText = ""}) {
    return TextFormField(
      keyboardType: type,
      validator: (s) {
        if (s!.length <= 2) {
          return "Lütfen giriş yapınız";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: hint,
        labelText: labelText,
        prefix: Text(prefixText),
        prefixIcon: textIcon,
      ),
    );
  }

  void _getAllGames() async {
    _allGame = await _hive.getAllGame();
    setState(() {});
  }
}
