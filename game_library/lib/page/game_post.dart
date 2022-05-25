import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:game_library/services/fire_storage.dart';

class GamePost extends StatefulWidget {
  const GamePost({Key? key}) : super(key: key);

  @override
  State<GamePost> createState() => _GamePostState();
}

class _GamePostState extends State<GamePost> {
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
    TextEditingController editingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2),
            child: StreamBuilder(
              stream: _postAddServices.getPost(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: editingController,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 5)),
                          labelText: "Oyun önerisinde bulun")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            try {
                              if (editingController.text.isNotEmpty) {
                                _postAddServices.addPost(
                                    editingController.text,
                                    _auth.currentUser!.email.toString(),
                                    _auth.currentUser!.uid.toString());
                              }
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                            editingController.text = "";
                          },
                          icon: const Icon(Icons.share),
                          label: const Text("Paylaş")),
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, "/myPost");
                          },
                          icon: const Icon(Icons.my_library_books),
                          label: const Text("Postlarim"))
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
