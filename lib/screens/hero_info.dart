
import 'package:flutter/material.dart';
import 'package:json_parse_lab/models/hero.dart';

class HeroInfo extends StatefulWidget {

  final MyHero hero;
  Function(MyHero hero) onToggleFavorite;
  Function(MyHero hero) containsFavorite;
  Function() notify;

  HeroInfo({required this.hero, required this.containsFavorite, required this.onToggleFavorite, required this.notify});

  @override
  State<HeroInfo> createState() => _HeroInfoState();
}

// class _HeroInfoState extends State<HeroInfo> {
//   @override
//   Widget build(BuildContext context) {
//
//     MyHero hero = widget.hero;
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(hero.name ?? "Unknown"),
//           elevation: 0,
//           centerTitle: true,
//           leading: BackButton(
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         body: Column(
//           children: [
//             const SizedBox(height: 10,),
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Image.network('${hero.images?.lg}', scale: 2.5,),
//                       const SizedBox(height: 10,),
//                       Text('${hero.name}'),
//                       Text('${hero.slug}'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10,),
//             Column(
//               children: [
//                 const SizedBox(width: 15,),
//                 Column(
//                   children: [
//                     const Text("Appearance"),
//                     Text(hero.appearance.toString(),),
//                   ],
//                 ),
//                 const SizedBox(height: 10,),
//                 Column(
//                   children: [
//                     const Text('Biography'),
//                     Text(hero.biography.toString()),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class _HeroInfoState extends State<HeroInfo> {

  @override
  Widget build(BuildContext context) {
    MyHero hero = widget.hero;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          hero.name ?? "Unknown",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('${hero.images?.lg}', scale: 2.5,),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Appearance",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                hero.appearance.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Biography",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                hero.biography.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.onToggleFavorite(hero);
            widget.notify();
          });
        },
        child: Icon(
          widget.containsFavorite(hero)
            ? Icons.star
            : Icons.star_border,
          ),
      ),
    );
  }
}
