import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:game_library/services/fire_auth.dart';

import '../constants/constants.dart';
import '../model/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AuthServices _authServices;
  late final FirebaseAuth _auth;
  late UserModel users;
  late Future<UserModel> userCurrent;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _authServices = AuthServices();
    users = UserModel.empty();
    try {
      userCurrent = getUser(_auth.currentUser!.uid);
      userCurrent.then((value) => users = value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("Welcome"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  _authServices.signOut();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(primary: Colors.blue[200]),
                icon: const Icon(Icons.exit_to_app),
                label: const Text("")),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            title: Text(
              "Game Library",
              style: ConstantsStyles.titleStyle,
            ),
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(
                  "assets/images/mainimg.png",
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(0.8),
                  colorBlendMode: BlendMode.modulate,
                )),
          ),
          SliverGrid(
              delegate: SliverChildListDelegate([
                buttons("Games", Icons.gamepad, context, "/gameApi"),
                buttons(
                    "Oyun Satış ", Icons.shopping_bag, context, "/shopping"),
                buttons("Oyunlar Hakkında bilgiler", Icons.auto_stories,
                    context, "/gameAbout"),
                buttons("Oyun Ekle", Icons.add_box, context, "/gameAddLibrary"),
                buttons("Oyun Kütüphanem", Icons.library_books, context,
                    "/gameLibrary"),
                buttons("Kişisel Verileriniz", Icons.folder_shared_outlined,
                    context, "/personalData"),
                buttons(
                    "Oyun Motorları", Icons.settings, context, "/gameEngine"),
                buttons("Hakkımızda ve İletişim", Icons.comment_bank_outlined,
                    context, "/about"),
                buttons("Ankete Katılın", Icons.how_to_reg_outlined, context,
                    "/quastionGame"),
                buttons("Oyun Haberleri ", Icons.new_releases_outlined, context,
                    "/gamenews"),
                buttons("Oyun Postları ", Icons.post_add_sharp, context,
                    "/gamePost"),
                buttons("Alışveriş geçmişi ", Icons.history, context,
                    "/shoppingHistory"),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2))
        ],
      ),
    );
  }

  Future<UserModel> getUser(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot doc) => UserModel.fromSnapShot(doc));
  }
}

Widget buttons(
    String data, IconData icon, BuildContext context, String targetPage) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade800,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Colors.white, width: 5)),
            shadowColor: Colors.blueGrey,
            elevation: 50,
            textStyle: ConstantsStyles.textStyle),
        onPressed: () {
          Navigator.of(context).pushNamed(targetPage);
        },
        icon: Icon(
          icon,
          size: 47,
        ),
        label: Text(data)),
  );
}
