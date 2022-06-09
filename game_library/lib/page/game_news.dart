import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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

class _GameNewsState extends State<GameNews>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  late Animation animation3;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller.addListener(() {
      setState(() {});
    });
    animation = AlignmentTween(begin:const Alignment(1, 1), end:const Alignment(-1, -1))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo));
    animation2 = AlignmentTween(begin:const Alignment(-1, 1), end:const Alignment(1, -1))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo));
    animation3 = AlignmentTween(begin:const Alignment(0, 1), end:const Alignment(0, -1))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo));
    controller.forward().orCancel;

    //controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(children: [
                Container(
                  alignment: animation.value,
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: iconContanier("assets/images/game1_icon.png"),
                ),
                Container(
                  alignment: animation2.value,
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: iconContanier("assets/images/game2_icon.png"),
                ),
                Container(
                  alignment: animation3.value,
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: iconContanier("assets/images/newspaper.png"),
                ),
              ]),
            ),
           const Text(
              "Oyun Haberleri",
              textAlign: TextAlign.end,
            ),
            const newsCard(),
            const SizedBox(height: 300, child: CarouselWithIndicatorDemo()),
          ],
        ),
      ),
    );
  }

  Container iconContanier(String imagePath) {
    return Container(
      decoration:const BoxDecoration(),
      child: Container(
        height: 64,
        width: 64,
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage(imagePath))),
      ),
    );
  }
}

// ignore: camel_case_types
class newsCard extends StatelessWidget {
  const newsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        child: Container(
          height: 500,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/GodOfWar_icon.png"),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "God Of War - IGN",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "17 min ago",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ]),
                ),
                const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                  size: 22,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "IGN's God of War (2018) complete strategy guide and walkthrough will lead you "
              "through every step of your Journey from the opening seconds to the end credits and beyond.",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onLongPress: () {
                    Navigator.pushNamed(context, "/imageDetail",
                        arguments:
                            "https://i0.wp.com/shiftdelete.net/wp-content/uploads/2021/10/god-of-war-pc-surumunden-yeni-bilgiler-ortaya-cikti.jpg?fit=1280%2C720&ssl=1");
                  },
                  child: Hero(
                    tag:
                        "https://i0.wp.com/shiftdelete.net/wp-content/uploads/2021/10/god-of-war-pc-surumunden-yeni-bilgiler-ortaya-cikti.jpg?fit=1280%2C720&ssl=1",
                    child: Container(
                      height: 200,
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/loading.gif",
                        image:
                            "https://i0.wp.com/shiftdelete.net/wp-content/uploads/2021/10/god-of-war-pc-surumunden-yeni-bilgiler-ortaya-cikti.jpg?fit=1280%2C720&ssl=1",
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        Navigator.pushNamed(context, "/imageDetail",
                            arguments:
                                "https://reimg-teknosa-cloud-prod.mncdn.com/mnresize/600/600/productimage/125089661/125089661_3_MC/8799685738546_1546942887267.jpg");
                      },
                      child: Hero(
                        tag:
                            "https://reimg-teknosa-cloud-prod.mncdn.com/mnresize/600/600/productimage/125089661/125089661_3_MC/8799685738546_1546942887267.jpg",
                        child: Container(
                          height: 95,
                          width: (MediaQuery.of(context).size.width - 100) / 2,
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.gif",
                            image:
                                "https://reimg-teknosa-cloud-prod.mncdn.com/mnresize/600/600/productimage/125089661/125089661_3_MC/8799685738546_1546942887267.jpg",
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onLongPress: () {
                        Navigator.pushNamed(context, "/imageDetail",
                            arguments:
                                "https://i.cnnturk.com/i/cnnturk/75/740x416/6229a6765cf3b024606c79cb.jpg");
                      },
                      child: Hero(
                        tag:
                            "https://i.cnnturk.com/i/cnnturk/75/740x416/6229a6765cf3b024606c79cb.jpg",
                        child: Container(
                          height: 95,
                          width: (MediaQuery.of(context).size.width - 100) / 2,
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.gif",
                            image:
                                "https://i.cnnturk.com/i/cnnturk/75/740x416/6229a6765cf3b024606c79cb.jpg",
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.brown.withOpacity(0.2),
                  ),
                  child: const Center(
                    child: Text(
                      "# GodOfWar",
                      style: TextStyle(fontSize: 10, color: Colors.brown),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.reply,
                  color: Colors.brown.withOpacity(0.4),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text("1.7k"),
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.comment,
                  color: Colors.brown.withOpacity(0.4),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text("325"),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 225,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("2.3k"),
                      ]),
                )
              ],
            )
          ]),
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
