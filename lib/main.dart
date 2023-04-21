import 'package:flutter/material.dart';
import 'package:json_parse_lab/models/hero.dart';
import 'package:http/http.dart' as http;
import 'package:json_parse_lab/screens/about.dart';
import 'package:json_parse_lab/screens/favourite_list.dart';
import 'dart:async';
import 'dart:convert';

import 'package:json_parse_lab/screens/heroes_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

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

  List<Widget> _pages = [];
  int _selectedIndex = 0;
  List<MyHero> _favorites = [];

  @override
  void initState() {
    _pages = [
      HeroesList(heroes: fetchAllHeroes(), onToggleFavorite: _toggleFavorite, containsFavorite: containsFavorite),
      FavoriteList(favourites: _favorites, onToggleFavorite: _toggleFavorite, containsFavorite: containsFavorite),
      AboutPage(),
    ];
    _selectedIndex = 0;
  }

  void _toggleFavorite(MyHero hero) {
    if (_favorites.contains(hero)) {
      _favorites.remove(hero);
    } else {
      _favorites.add(hero);
    }
  }

  bool containsFavorite(MyHero hero) {
    return _favorites.contains(hero);
  }

  void _navigate(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red
      ),
        home: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigate,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
            ],
          ),
        )
    );
  }


}
