import 'package:flutter/material.dart';

class HeroListPage extends StatelessWidget {
  const HeroListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hero ListView")),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView.builder(
            itemCount: _images.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SecondPage(heroTag: index),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Hero(
                        tag: index,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(_images[index], width: 200),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Title: $index',
                          style: Theme.of(context).textTheme.titleLarge,

                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final int heroTag;

  const SecondPage({Key? key, required this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hero ListView Page 2")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(_images[heroTag]),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Content goes here",
              style: Theme.of(context).textTheme.headlineSmall,


            ),
          ),
        ],
      ),
    );
  }
}
//parece que no carga desde aqui 
final List<String> _images = [
  'https://cdn-files.kimovil.com/phone_front/0007/94/thumb_693379_phone_front_big.jpg',
  'https://cdn-files.kimovil.com/default/0007/94/thumb_693382_default_big.jpg',
  'https://cdn-files.kimovil.com/default/0007/93/thumb_692719_default_big.jpg',
  'https://cdn-files.kimovil.com/default/0007/94/thumb_693390_default_big.jpg',
  'https://cdn-files.kimovil.com/default/0008/33/thumb_732955_default_big.jpg',
  'https://cdn-files.kimovil.com/default/0008/33/thumb_732947_default_big.jpg',
];
