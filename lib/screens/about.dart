import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heroes App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Heroes App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img.jpeg', height: 350,),
              ],
            ),
            const SizedBox(height: 20,),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Heroes App is a mobile application that allows users to view information about their favorite heroes and villains from various comic book universes. With a sleek and intuitive user interface, users can browse character profiles, view their stats and abilities, and keep up-to-date with the latest news and updates in the world of comic books.',
              style: TextStyle(
                fontSize: 16.0,
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
    playSong();

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playSong();
      });
    });

  }

  void playSong() async {
    final player = AudioCache(prefix: "assets/");
    final url = await player.load('song3.mp3');
    audioPlayer.setUrl(url.path, isLocal: true);
    audioPlayer.resume();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }
}



