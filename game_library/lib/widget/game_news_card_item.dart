import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String head;
  final String content;
  const CardItem({required this.head, required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 20,
            offset: const Offset(10, 10))
      ]),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  head,
                  style: const TextStyle(fontSize: 30),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.favorite)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
