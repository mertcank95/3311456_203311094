import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:game_library/datasource/gamenews_source.dart';
import 'package:game_library/widget/game_news_card_item.dart';

final List<String> imgList = [
  'https://www.btgunlugu.com/wp-content/uploads/2021/05/wqrq23.jpg',
  'https://foto.haberler.com/haber/2022/02/22/elden-ring-in-cikisina-sayili-gunler-kala-6-14749640_5673_amp.jpg',
  'https://img-s1.onedio.com/id-61a9251a88fbf4631ca1f4ca/rev-0/w-620/f-jpg/s-61826491adece2e3550c9eefd3f5d26990af8bc9.jpg',
  'https://i2.milimaj.com/i/milliyet/75/0x186/5e218568adcdeb19746db805.jpg',
  'https://www.minecraft.net/content/dam/games/minecraft/marketplace/updates-updateaquatic_latest.jpg',
  'https://images.everyeye.it/img-notizie/steam-deck-scheggia-fast-resume-giochi-riflessioni-peter-durante-v3-558292-1280x720.webp'
];

final List<String> contentList = [
  'God of war pc için çıkış yaptı!!!!',
  'Elder ring çıktı ve çok beğenildi!!!!',
  'Dying Light Çıktı',
  '2022 yılına damga vurucak oyunlar',
  'En çok oynanan oyun minecraft',
  'Steam in yeni donanımı STEAM DECK'
];

class GameNews extends StatefulWidget {
  const GameNews({Key? key}) : super(key: key);

  @override
  State<GameNews> createState() => _GameNewsState();
}

class _GameNewsState extends State<GameNews> {
  @override
  Widget build(BuildContext context) {
    NewsGameDataSource dataSource = NewsGameDataSource();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsStyles.appBarColor,
        title: Text(
          "Game News",
          style: ConstantsStyles.titleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 280,
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      autoPlay: true),
                  items: imageSliders,
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CardItem(
                head: dataSource.title,
                content: dataSource.content,
              ),
            ),
            const SizedBox(height: 300, child: CarouselWithIndicatorDemo()),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CardItem(
                head: dataSource.title1,
                content: dataSource.content1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
            )
          ],
        ),
      ),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: item,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.yellow,
                              blurRadius: 1,
                              offset: Offset(5, 10))
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        contentList[imgList.indexOf(item)],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ))
    .toList();
