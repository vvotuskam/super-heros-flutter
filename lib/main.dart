import 'package:flutter/material.dart';
import 'package:json_parse_lab/models/hero.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
        primarySwatch: Colors.blue,
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

  Widget listViewWidget(List<MyHero> heroes) {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                title: Text(
                  '${heroes[position].name}',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: heroes[position].images == null
                        ? Image(
                      image: AssetImage('images/no_image_available.png'),
                    )
                        : Image.network('${heroes[position].images?.md}'),
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                onTap: null,
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchAllHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("HEROES"),
      ),
      body: FutureBuilder(
          future: fetchAllHeroes(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data!)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }


}
