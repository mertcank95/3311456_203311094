import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/controller/route_controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(229, 228, 235, 230)),
      //home: MainPage(),
      onGenerateRoute: RouteControl.routeGenerator,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: ConstantsStyles.appBarColor,
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
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2))
        ],
      ),
    );
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
