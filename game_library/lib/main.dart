import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';

import 'package:game_library/controller/route_controller.dart';
import 'package:game_library/firebase_options.dart';
import 'package:game_library/model/game_shop_model.dart';
import 'package:game_library/widget/login_widget.dart';
import 'package:game_library/widget/sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GameShopModelAdapter());
  await Hive.openBox<GameShopModel>("game");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primaryColor: const Color.fromARGB(229, 228, 235, 230),
          appBarTheme: const AppBarTheme(color: ConstantsStyles.appBarColor)),
      //home: MainPage(),
      onGenerateRoute: RouteControl.routeGenerator,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue[100]),
                tabs: [
                  Container(
                    decoration: BoxDecoration(
                        //color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(30)),
                    child: Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Login"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.login)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        //color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(30)),
                    child: Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Sign In"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.edit)
                        ],
                      ),
                    ),
                  ),
                ])),
        body:const TabBarView(
          children: [LoginPage(), SignIn()],
        ),
      ),
    );
  }
}
