import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gameguess/games1.dart';
class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late Game _game;
  final _controller = TextEditingController();
  String? _guesss;
  bool newGame = false;

  void _showMaterialDialog(String title, String msg ){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.mitr(fontSize: 30),
          ),
          content: Text(
            msg,
            style: GoogleFonts.mitr(fontSize: 20),
          ),

          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showMaterialDialog1(String title,String feed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.mitr(fontSize: 20),
          ),
          content: Text(
            feed,
            style: GoogleFonts.mitr(fontSize: 15),
          ),

          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS THE NUMBER', style: GoogleFonts.mitr()),
        backgroundColor: Colors.purpleAccent.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple[800]),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(16),
          child: Center(
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 100.0),
                    Column(
                      children: [
                        Text(
                            ' GUESS',
                            style: TextStyle(fontSize: 30.0,color: Colors.lightBlue.shade300),
                            textAlign: TextAlign.center
                        ),
                        Text(
                            '  THE NUMBER',
                            style: TextStyle(fontSize: 16.0, color: Colors.blue.shade300),
                            textAlign: TextAlign.center
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                border: OutlineInputBorder(),
                                hintText: 'ทายเลขตั้งแต่ 1 ถึง 100',
                              ),
                            )
                        ),
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _guesss = _controller.text;
                                    int? guess = int.tryParse(_guesss!);
                                    if (guess != null) {
                                      var count = _game.doGuess(guess);
                                      var sum = _game.totalGuesses;
                                      if (count == 0) {
                                        newGame = true;
                                        _showMaterialDialog("RESULT",
                                            '$_guesss ถูกต้องแล้วครับ 🎉\nคุณทายทั้งหมด $sum ครั้ง');
                                        _controller.clear();
                                      } else if (count == 1) {
                                        _showMaterialDialog1("RESULT",'$_guesss มากเกินไป กรุณาลองใหม่');
                                        _controller.clear();
                                      } else {
                                        _showMaterialDialog1("RESULT",'$_guesss น้อยเกินไป กรุณาลองใหม่');
                                        _controller.clear();
                                      }
                                    } else {
                                      _showMaterialDialog('Error', 'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น');
                                      _controller.clear();
                                      newGame = false;
                                    }
                                  }
                                  );
                                },
                                child: Text(' GUESS',
                                  style: GoogleFonts.mitr(
                                      fontSize: 15, color: Colors.cyan),)
                            ),
                          ],
                        ),

                      ],
                    )

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return _guesss == null
        ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      ],
    )
        : Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(_guesss!,
              style: GoogleFonts.mitr(
                  fontSize: 40, color: Colors.deepOrangeAccent)),
        ),
        if (newGame)
          TextButton(
              onPressed: () {
                setState(() {
                  _game = Game();
                  newGame = false;
                  _guesss= null;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    //borderRadius: BorderRadius.circular(.0),
                    border: Border.all(width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'NEW GAME',
                      style: GoogleFonts.mitr(
                          fontSize: 15, color: Colors.lightBlueAccent),
                    ),
                  ),
                ),
              )),
      ],
    );
  }

}
