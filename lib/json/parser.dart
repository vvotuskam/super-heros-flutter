import 'package:json_parse_lab/models/hero.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class JsonParser {
  final String baseUrl = 'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/';

  Future<List<Hero>> getAllHeroes() async {
    List<Hero> heroes = [];
    String url = '${baseUrl}all.json';
    var response = await http.get(Uri.parse(url));
    print(response.body);

    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data['heroes'];
      //print(rest);

      heroes = rest.map<Hero>((json) => Hero.fromJson(json)).toList();
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