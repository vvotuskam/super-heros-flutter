import 'package:flutter/material.dart';
import 'package:json_parse_lab/json/preferences_manager.dart';

import '../models/hero.dart';
import 'hero_info.dart';

class FavoriteList extends StatefulWidget {
  FavoriteList({required this.favourites, required this.onToggleFavorite, required this.containsFavorite});
  Future<List<MyHero>> favourites;
  Function(MyHero hero) onToggleFavorite;
  Function(MyHero hero) containsFavorite;

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {

  void refresh() {
    setState(() {

    });
  }

  Widget customCard(MyHero hero) {
    String race = hero.appearance?.race ?? "Unknown";
    PreferencesManager prefManager = PreferencesManager();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              HeroInfo(hero: hero, containsFavorite: widget.containsFavorite, onToggleFavorite: widget.onToggleFavorite, notify: refresh,)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network('${hero.images?.sm}', scale: 2,),
                const SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${hero.name}',
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      race,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )

              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.onToggleFavorite(hero);
                });
              },
              icon: FutureBuilder(
                future: prefManager.containsFavourite(hero),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Icon(Icons.star_border,);
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.star_border);
                  } else if (snapshot.data!) {
                    return const Icon(Icons.star, color: Colors.red,);
                  } else {
                    return const Icon(Icons.star_border);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewWidget(List<MyHero> heroes) {
    return ListView.builder(
        itemCount: heroes.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return customCard(heroes[position]);
        });
  }


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    PreferencesManager prefsManager = PreferencesManager();
    widget.favourites = prefsManager.getAll();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: widget.favourites,
            builder: (context, snapshot) {
              print(snapshot.data.toString());
              return snapshot.data != null
                  ? listViewWidget(snapshot.data!)
                  : const Center(child: CircularProgressIndicator());
            }),
      )
    );
  }
}