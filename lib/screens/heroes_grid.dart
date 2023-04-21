import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_parse_lab/screens/hero_info.dart';
import 'dart:async';
import 'dart:convert';

import '../models/hero.dart';

class HeroesList extends StatefulWidget {
  HeroesList({required this.heroes, required this.onToggleFavorite, required this.containsFavorite});
  Future<List<MyHero>> heroes;
  Function(MyHero hero) onToggleFavorite;
  Function(MyHero hero) containsFavorite;

  @override
  State<HeroesList> createState() => _HeroesListState();

}

class _HeroesListState extends State<HeroesList> {

  void refresh() {
    setState(() {

    });
  }

  Future<List<MyHero>> fetchAllHeroes() async {
    List<MyHero> heroes = [];
    const String baseUrl = 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/';
    String url = '${baseUrl}all.json';
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      heroes = data.map<MyHero>((json) => MyHero.fromJson(json)).toList();
    }
    return heroes;
  }

  Widget listViewWidget(List<MyHero> heroes) {
    return ListView.builder(
        itemCount: heroes.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return customCard(heroes[position]);
        });
  }

  Widget customCard(MyHero hero) {
    String race = hero.appearance?.race ?? "Unknown";
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                HeroInfo(hero: hero, containsFavorite: widget.containsFavorite, onToggleFavorite: widget.onToggleFavorite, notify: refresh)),
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
              icon: Icon(
                widget.containsFavorite(hero)
                    ? Icons.star
                    : Icons.star_border,
                color: widget.containsFavorite(hero)
                    ? Colors.red
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchAllHeroes();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Heroes App'),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: widget.heroes,
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? listViewWidget(snapshot.data!)
                  : const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
