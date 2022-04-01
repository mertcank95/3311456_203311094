import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/datasource/game_engine_data.dart';
import 'package:game_library/widget/game_news_card_item.dart';

final List<String> imgList = [
  'https://cdn.wmaraci.com/nedir/unreal-engine.png',
  'https://www.hubogi.com/wp-content/uploads/2021/08/Saving-Data-In-Unity-PlayerPrefs.jpg',
  'https://www.webtekno.com/images/editor/default/0002/54/fb6a07d284462617e473d21757e34e70fbb53b37.jpeg',
  'http://bilgisayarhane.net/wp-content/uploads/2020/06/unity-beta-dark-cust.jpg'
];

class GameEngine extends StatelessWidget {
  const GameEngine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsStyles.appBarColor,
        title: Text(
          "Game Engine",
          style: ConstantsStyles.titleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/loading.gif",
                      image: imgList[0],
                      width: 175,
                    ),
                  ),
                  const SizedBox(width: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/loading.gif",
                      image: imgList[1],
                      width: 175,
                    ),
                  )
                ],
              ),
            ),
            const CardItem(
                head: "Oyun Motoru Nedir ?", content: GameEngineData.gameEnine),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.gif",
                  image: imgList[2],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const CardItem(
                head: "Unreal Engine", content: GameEngineData.unreal),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.gif",
                  image: imgList[3],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const CardItem(head: "Unity", content: GameEngineData.gameEnine)
          ],
        ),
      ),
    );
  }
}
