import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;
  bool showForm = false;
  bool _hide = true;
  late final FirebaseAuth _auth;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        Navigator.pushNamed(context, "/home");
      }
    });
    controller = AnimationController(vsync: this);
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 18, end: 40),
            from: Duration.zero,
            to: const Duration(seconds: 1),
            tag: "welcome")
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 25),
            from: const Duration(seconds: 1),
            to: const Duration(seconds: 2),
            tag: "login")
        .animate(controller);
    controller.forward().orCancel;
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showForm = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        controller.forward().orCancel;
      }
    });
  }

  @override
  void dispose() {
    controller.forward().orCancel;

    controller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? gmail;
  String? password;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext contex, Widget? widget) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    "WELCOME !",
                    style:
                        TextStyle(fontSize: sequenceAnimation["welcome"].value),
                  ),
                  Text("PLEASE LOGIN",
                      style: TextStyle(
                          fontSize: sequenceAnimation["login"].value)),
                  showForm
                      ? Card(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Düzgün kullanıcı adı giriniz";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        gmail = value;
                                      },
                                      decoration: const InputDecoration(
                                        label: Text("User Name"),
                                        icon: Icon(Icons.email),
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "hatalı giriş yaptınız";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        password = value;
                                      },
                                      obscureText: _hide,
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Text(""),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.blue[200]),
                      onPressed: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            await _auth.signInWithEmailAndPassword(
                                email: gmail!, password: password!);
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                        if (_auth.currentUser != null) {
                          Navigator.pushNamed(context, "/home");
                        } else {
                          debugPrint("kullanıcı yok");
                        }
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 25),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
