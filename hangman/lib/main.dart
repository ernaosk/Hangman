import 'package:flutter/material.dart';
import 'package:hangman/game/hangman.dart';
import 'package:hangman/ui/page.dart';

const List<String> wordList = const ["FLUTTER","PROGRAMMING","CLASS","SCHOOL",
  "FUTURE", "LANGUAGE","CARRIER","BILL","MOTHER","ARGUE","HANGMAN","GROW","VOTING","SHUT",
  "PILL", "OPPOSED","FLAG","RACE","SPEED","BIAS","HERSELF","DOUGH","RELEASE","SUBJECT",
  "PUSH", "FANTASY","PLAN","LAST","ATTACK","COIN","ONE","STEM","SCAN","ENHANCE",
  "BRICK","SURVIVE","LEADING","STAKE","NERVE","INTENSE","SUSPECT","WHEN","LIE",
  "SPOILED","ANALYSE","VARIANCE","ROLLING","MEANING","RESPECT","PLURAL"];

void main() => runApp(HangmanApp());

class HangmanApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HangmanAppState();
}

class _HangmanAppState extends State<HangmanApp> {
  HangmanGame _engine;

  @override
  void initState() {
    super.initState();

    _engine = HangmanGame(wordList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HangmanPage(_engine),
    );
  }
}