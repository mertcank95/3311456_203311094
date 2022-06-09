import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';

import '../services/fire_storage.dart';

class GameList extends StatefulWidget {
  final Function onDismis;

  const GameList({required this.onDismis, Key? key}) : super(key: key);

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  late FireStorageServices _services;
  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _services = FireStorageServices();
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _services.getCurrentUserGame(_auth.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (BuildContext context, int index) {
                  var myGame = snapshot.data!.docs[index];
                  return Dismissible(
                    onDismissed: (direction) {
                      widget.onDismis(myGame);
                    },
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: newCard(myGame, index),
                    ),
                  );
                })
            : const CircularProgressIndicator();
      },
    );
  }
}

Card newCard(QueryDocumentSnapshot<dynamic> game, int index) {
  return Card(
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(color: Colors.blue.shade100, width: 2)),
      child: ListTile(
          trailing: Text(game['gameName']),
          leading: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Text(
                game['gameDate'],
                textAlign: TextAlign.center,
              )),
          subtitle: Text(game['gameContent']),
          title: Text(
            game['gameType'],
            style: ConstantsStyles.newsTitle,
          )));
}
