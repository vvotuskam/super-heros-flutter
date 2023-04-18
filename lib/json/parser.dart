import 'package:json_parse_lab/models/hero.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class JsonParser {
  final String baseUrl = 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/';

  final _heroesController = StreamController<List<MyHero>>();
  List<MyHero> heroes = [];

  Stream<List<MyHero>> get heroesStream => _heroesController.stream;

  Future<List<MyHero>> fetchAllHeroes() async {
    List<MyHero> heroes = [];
    String url = '${baseUrl}all.json';
    var response = await http.get(Uri.parse(url));
    //print(response.body);

    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      //print(data);
      //print(rest);

      heroes = data.map<MyHero>((json) => MyHero.fromJson(json)).toList();
    }
    return heroes;
  }
}

/*

"connections": {

"groupAffiliation": "
Hulk Family; Excelsior (sponsor), Avengers (honorary member); formerly partner of the Hulk, Captain America and Captain Marvel; Teen Brigade; ally of Rom",
"relatives":
"Marlo Chandler-Jones (wife); Polly (aunt); Mrs. Chandler (mother-in-law); Keith Chandler, Ray Chandler, three unidentified others (brothers-in-law); unidentified father (deceased); Jackie Shorr (alleged mother; unconfirmed)"
    },

 */