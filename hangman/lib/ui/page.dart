import 'package:flutter/material.dart';

import 'package:hangman/game/hangman.dart';

const List<String> progressImages = const [
  'images/image_0.png',
  'images/image_1.png',
  'images/image_2.png',
  'images/image_3.png',
  'images/image_4.png',
  'images/image_5.png',
  'images/image_6.png',
  'images/image_dead.png',

];

const String victoryImage = 'images/image_victory.png';

const List<String> alphabet = const [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
];

const TextStyle activeWordStyle = TextStyle(
  fontSize: 30.0,
  letterSpacing: 5.0,
);

class HangmanPage extends StatefulWidget {
  final HangmanGame _engine;

  HangmanPage(this._engine);

  @override
  State<StatefulWidget> createState() => _HangmanPageState();
}

class _HangmanPageState extends State<HangmanPage> {
  bool _showNewGame;
  String _activeImage;
  String _activeWord;

  @override
  void initState() {
    super.initState();

    widget._engine.onChange.listen(this._updateWordDisplay);
    widget._engine.onWrong.listen(this._updateGallowsImage);
    widget._engine.onWin.listen(this._win);
    widget._engine.onLose.listen(this._gameOver);

    this._newGame();
  }

  void _updateWordDisplay(String word) {
    this.setState(() {
      _activeWord = word;
    });
  }

  void _updateGallowsImage(int wrongGuessCount) {
    this.setState(() {
      _activeImage = progressImages[wrongGuessCount];
    });
  }

  void _win([_]) {
    this.setState(() {
      _activeImage = victoryImage;
      this._gameOver();
    });
  }

  void _gameOver([_]) {
    this.setState(() {
      _showNewGame = true;
    });
  }

  void _newGame() {
    widget._engine.newGame();

    this.setState(() {
      _activeWord = '';
      _activeImage = progressImages[0];
      _showNewGame = false;
    });
  }

  Widget _renderBottomContent() {
    if (_showNewGame) {
      return RaisedButton(
        child: Text('New Game'),
        onPressed: this._newGame,
      );
    } else {
      final Set<String> lettersGuessed = widget._engine.lettersGuessed;

      return Wrap(
        spacing: 1.0,
        runSpacing: 1.0,
        alignment: WrapAlignment.center,
        children: alphabet.map((letter) => MaterialButton(
          child: Text(letter),
          padding: EdgeInsets.all(2.0),
          onPressed: lettersGuessed.contains(letter) ? null : () {
            widget._engine.guessLetter(letter);
          },
        )).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hangman'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image
            Expanded(
              child: Image.asset(_activeImage),
            ),
            // Word
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(_activeWord, style: activeWordStyle),
              ),
            ),
            // Controls
            Expanded(
              child: Center(
                child: this._renderBottomContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget RaisedButton({Text child, void Function() onPressed}) {
}