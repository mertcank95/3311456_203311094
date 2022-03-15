import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsStyles.appBarColor,
        title: Text(
          "Hakkımızda...",
          style: ConstantsStyles.titleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/welcome.png"),
            ),
            Text("Program uygulama ve Oyun geliştirme topluluğu",
                style: ConstantsStyles.newsTitle, textAlign: TextAlign.center),
          ],
        )),
      ),
    );
  }
}
