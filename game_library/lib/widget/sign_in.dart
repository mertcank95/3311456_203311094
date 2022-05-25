import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:game_library/model/user_model.dart';

import '../services/fire_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel newUser = UserModel.empty();
  final AuthServices _authServices = AuthServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _hide = false;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          setState(() {
                            newUser.name = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Düzgün veriler giriniz";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          label: Text("Name"),
                          icon: Icon(Icons.people),
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          setState(() {
                            newUser.surName = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Düzgün veriler giriniz";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          label: Text("Sur name"),
                          icon: Icon(Icons.people),
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          setState(() {
                            newUser.gmail = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Düzgün veriler giriniz";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          label: Text("Gmail"),
                          icon: Icon(Icons.mail),
                        ),
                      ),
                      TextFormField(
                        obscureText: _hide,
                        onSaved: (value) {
                          setState(() {
                            newUser.password = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Düzgün veriler giriniz";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text("Password"),
                            icon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_hide
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _hide = !_hide;
                                });
                              },
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[200]),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              _authServices.createPerson(newUser);
                              if (_auth.currentUser != null) {
                                Navigator.pushNamed(context, "/home");
                              } else {
                                debugPrint("kullanıcı yok");
                              }
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Sign Up"))
                    ],
                  ),
                )),
          ),
        ),
      ),
    ));
  }
}
