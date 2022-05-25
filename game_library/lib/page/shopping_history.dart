import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_library/services/fire_storage.dart';

class ShopingHistory extends StatefulWidget {
  const ShopingHistory({Key? key}) : super(key: key);

  @override
  State<ShopingHistory> createState() => _ShopingHistoryState();
}

class _ShopingHistoryState extends State<ShopingHistory> {
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
    return Scaffold(
      body: StreamBuilder(
        stream: _services.getCurrentUserShopHistory(_auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    var myPost = snapshot.data!.docs[index];
                    Map<dynamic, dynamic> a = myPost["games"];
                    var gameList = a.entries.toList();

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(myPost['totalMoney']),
                              InkWell(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.arrow_downward))
                            ],
                          ),
                          subtitle: Column(
                              children: gameList
                                  .map((e) => Text(e.key + " " + e.value))
                                  .toList()),
                        ),
                      ),
                    );
                  },
                )
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
