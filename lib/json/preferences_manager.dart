import 'dart:ffi';

import 'package:json_parse_lab/json/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/hero.dart';

class PreferencesManager {


  final jsonParser = JsonParser();
  final key = 'favorites';


  void initFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, []);
  }

  void addFavourite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? obj = prefs.getStringList(key);
    List<String> favourites = obj ?? [];

    // favourites.add(id as String);
    favourites.add(id.toString());
    prefs.setStringList(key, favourites);
    print("added");
    print(prefs.getStringList(key));

  }


  void removeFavourite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? obj = prefs.getStringList(key);
    List<String> favourites = obj ?? [];

    favourites.remove(id.toString());
    print("removed");
    print(favourites.toString());
    prefs.setStringList(key, favourites);
  }

  void addRemoveFavourite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? obj = prefs.getStringList(key);
    List<String> favourites = obj ?? [];

    int index = -1;
    for (var i = 0; i < favourites.length; i++) {
      if (int.parse(favourites[i]) == id) {
        index = i;
      }
    }
    if (index == -1) {
      favourites.add(id.toString());
    } else {
      favourites.removeAt(index);
    }

    prefs.setStringList(key, favourites);

  }

  Future<List<MyHero>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList(key)!; // ids

    List<MyHero> heroes = [];
    List<MyHero> allHeroes = await jsonParser.fetchAllHeroes();

    for (var hero in allHeroes) {
      for (var id in ids) {
        if (int.parse(id) == hero.id!) {
          heroes.add(hero);
        }
      }
    }

    return heroes;
  }

  Future<bool> containsFavourite(MyHero hero) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList(key) ?? [];
    bool c = false;
    for (var id in ids) {
      if (int.parse(id) == hero.id) {
        c = true;
        break;
      }
    }
    return Future.value(c);
  }

  bool contains(MyHero hero) {
    containsFavourite(hero).then((value) {
      return value;
    });
    return false;
  }
}