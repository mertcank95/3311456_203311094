import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/controller/data_controller.dart';
import 'package:game_library/model/game_model.dart';
import 'package:game_library/services/fire_storage.dart';

import '../widget/game_type_dropdown.dart';

class GameAddLibrary extends StatefulWidget {
  const GameAddLibrary({Key? key}) : super(key: key);

  @override
  State<GameAddLibrary> createState() => _GameAddLibraryState();
}

class _GameAddLibraryState extends State<GameAddLibrary> {
  String gameName = "";
  String gameContent = "";
  String gameType = "Aksiyon";
  String dateTime = "0/0/0";
  late FireStorageServices fireServices;
  late FirebaseAuth _auth;
  @override
  void initState() {
    super.initState();
    fireServices = FireStorageServices();
    _auth = FirebaseAuth.instance;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DateTime dateNow = DateTime.now();

    DateTime fourMountAgo = DateTime(dateNow.year, dateNow.month - 4);

    DateTime tenDayAgo =
        DateTime(dateNow.year, dateNow.month, dateNow.day + 10);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Oyun Ekle",
          style: ConstantsStyles.titleStyle,
        ),
        backgroundColor: ConstantsStyles.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bitirdigin oyunu kaydet Kendi Oyun Kütüphaneni Oluştur",
                style: ConstantsStyles.newsTitle,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        _buildTextFormField(),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTextAreaFormField(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Oyun türünü seçiniz  ",
                              style: ConstantsStyles.textStyle,
                            ),
                            GameTypeDropdownWidget(
                              onSelectDropDown: (value) {
                                gameType = value;
                              },
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "oyunun bitiriliş tarihi   ",
                                style: ConstantsStyles.textStyle,
                              ),
                              ElevatedButton(
                                child: Text(dateTime),
                                style: ElevatedButton.styleFrom(
                                    primary: ConstantsStyles.textFormColor),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: dateNow,
                                          firstDate: fourMountAgo,
                                          lastDate: tenDayAgo)
                                      .then((value) {
                                    setState(() {});
                                    dateTime =
                                        "${value!.day}/${value.month}/${value.year}";
                                  });
                                },
                              )
                            ]),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: Text(
                            "Oyunu ekle",
                            style: ConstantsStyles.textStyle,
                          ),
                          onPressed: () {
                            try {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                GameModel newGame = GameModel(
                                    userId: _auth.currentUser!.uid,
                                    gameContent: gameContent,
                                    gameName: gameName,
                                    gameType: gameType,
                                    gameDate: dateTime);
                                fireServices
                                    .addGame(newGame)
                                    .then((value) => Navigator.pop(context));

                                DataControl.gameAdd(newGame);
                              } else {}
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "lütfen düzgün veriler giriniz")));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              primary: ConstantsStyles.textFormColor),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (value) {
        setState(() {
          gameName = value!;
        });
      },
      validator: (s) {
        if (s!.isEmpty) {
          return "Oyun Adini giriniz";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText: "oyun adı",
          hintStyle: ConstantsStyles.textStyle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: ConstantsStyles.textFormColor),
    );
  }

  _buildTextAreaFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onSaved: (value) {
        setState(() {
          gameContent = value!;
        });
      },
      validator: (s) {
        if (s!.isEmpty) {
          return 'Oyun içeriğini giriniz';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText: "oyun içeriği",
          hintStyle: ConstantsStyles.textStyle,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: ConstantsStyles.textFormColor),
    );
  }
}
