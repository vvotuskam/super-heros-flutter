import 'dart:ffi';

import 'package:json_parse_lab/json/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/hero.dart';

class PreferencesManager {

  final jsonParser = JsonParser();

  void addFavourite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? obj = prefs.getStringList('favorites');

    List<String> favourites = obj ?? [];

    favourites.add(id as String);
  }

  void removeFavourite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? obj = prefs.getStringList('favorites');

    List<String> favourites = obj ?? [];

    favourites.remove(id as String);
  }

  Future<List<MyHero>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList('favorites') ?? []; // ids

    List<MyHero> heroes = []; // heroes
    for (var id in ids) {
      heroes.add(await jsonParser.fetchHero(id as int));
    }

    return heroes;
  }

  Future<bool> containsFavourite(MyHero hero) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList('favorites') ?? []; // ids
    for (var id in ids) {
      if (id as int == hero.id!) {
        return true;
      }
    }
    return false;
  }
}