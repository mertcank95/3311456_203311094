import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:game_library/services/fire_storage.dart';

class MyGamePost extends StatefulWidget {
  const MyGamePost({Key? key}) : super(key: key);

  @override
  State<MyGamePost> createState() => _MyGamePost();
}

class _MyGamePost extends State<MyGamePost> {
  late FirebaseAuth _auth;
  late FireStorageServices _postAddServices;
  Color favoriteButton = Colors.white;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _postAddServices = FireStorageServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: StreamBuilder(
          stream: _postAddServices.getCurrentUserPost(_auth.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return !snapshot.hasData
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      var myPost = snapshot.data!.docs[index];
                      return Card(
                        child: Container(
                          color: Colors.green[50],
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            title: Text(myPost['gmail']),
                            subtitle: Text(myPost['post']),
                            leading: InkWell(
                                onTap: () {
                                  _postAddServices.removePost(myPost.id);
                                  print(myPost.id);
                                },
                                child: Icon(Icons.delete)),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
