import 'package:flutter/material.dart';

class ImageDetail extends StatelessWidget {
  final String imagePath;
  const ImageDetail({required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pop(context);
      },
      child: Hero(
        tag: imagePath,
        child: FadeInImage.assetNetwork(
          placeholder: "assets/images/loading.gif",
          image: imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
