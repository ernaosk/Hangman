import 'package:flutter/material.dart';
import 'dart:core';
import 'package:hangman/ui/widget/figure_image.dart';
import 'package:hangman/ui/widget/letter.dart';
import 'package:hangman/utils/game.dart';
import 'ui/widget/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp,
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  //choosing the game word
  String word = "Flutter".toUpperCase();
  //List = the alphabet
  List<String> alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("Hangman"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ), //AppBar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                // Here i make the figure widget.
                // The figure will be built according to the number of tries.
                figureImage(Game.tries >= 0, "images/body 1.png"),
                figureImage(Game.tries >= 1, "images/hang 2.png"),
                figureImage(Game.tries >= 2, "images/head 3.png"),
                figureImage(Game.tries >= 3, "images/la 4.png"),
                figureImage(Game.tries >= 4, "images/ll 5.png"),
                figureImage(Game.tries >= 5, "images/ra 6.png"),
                figureImage(Game.tries >= 6, "images/rl 7.png"),
              ],
            ),
          )
          SizedBox(
            height: 20,
          )
          // The hidden word widget.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          )

          // Building the game keyboard.
          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0),
              children: alphabet.map((e){
                // Building the game logic
                return RawMaterialButton(
                    onPressed: Game.selectedChar.contains(e)
                        ?null // first it check´s that we didn´t select the button before
                        : () {
                      setState(() {
                        Game.selectedChar.add(e);
                        print(Game.selectedChar);
                        if(!word.split('').contains(e.toUpperCase())) {
                          Game.tries++
                        }
                        });
                    },

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(e,style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),)
                fillColor:  Game.selectedChar.contains(e)
                    color: Colors.black87,
                    color: Colors.blue,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
