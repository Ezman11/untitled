import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/Game/game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late game _game;
  var input = '';
  final _controller = TextEditingController();
  bool _start = false;
  bool _end = false;
  String _feedback = '';

  @override
  void initState() {
    super.initState();
    _game = game();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildInputPanel() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TextField(
              enabled: _end ? false : true,
              style: TextStyle(color: Colors.white),
              controller: _controller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'Enter the number here',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16.0,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 10.0),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: !_end
                ? () {
                    setState(() {
                      _start = true;
                      input = _controller.text;
                      int? guess = int.tryParse(input);
                      if(guess != null){
                        if (_end) {
                          _showMaterialDialog('Game Is End!', 'please New Game');
                        }
                        if (guess != null) {
                          var result = _game.doGuess(guess);
                          if (result == 0) {
                            _feedback = 'CORRECT';
                            _end = true;
                            var showHistory = '';

                            for (int item in _game.getHistoryInput()) {
                              showHistory += item.toString() + ' -> ';
                            }
                            showHistory =
                                showHistory.substring(0, showHistory.length - 4);
                            _showMaterialDialog(
                                'GOOD JOB!',
                                'The answer is ' +
                                    _game.getAnswer() +
                                    '.\n'
                                        'You have made ' +
                                    _game.getTotalGuesses().toString() +
                                    ' guesses.\n\n' +
                                    showHistory);
                          } else if (result == 1) {
                            _feedback = 'TOO HIGH!';
                          } else {
                            _feedback = 'TOO LOW!';
                          }
                        }
                      }else{
                        _showMaterialDialog('Error', 'Please Enter Only Number');
                      }
                      _controller.clear();
                    });
                  }
                : null,
            child: Text('GUESS'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (_start) {
      return Column(
        children: [
          Text(
            input,
            style:
                GoogleFonts.mitr(fontSize: 60.0, color: Colors.white, shadows: [
              Shadow(
                blurRadius: 20.0,
                color: Colors.yellowAccent,
                offset: Offset(1.0, 1.0),
              ),
            ]),
            textAlign: TextAlign.center,
          ),
          !_end
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close_outlined,
                      size: 30,
                      color: Colors.red,
                    ),
                    Text(
                      _feedback,
                      style: GoogleFonts.mitr(
                          fontSize: 20.0,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 20.0,
                              color: Colors.yellowAccent,
                              offset: Offset(1.0, 1.0),
                            ),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.done_outline,
                          size: 30,
                          color: Colors.green,
                        ),
                        Text(
                          _feedback,
                          style: GoogleFonts.mitr(
                              fontSize: 20.0,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 20.0,
                                  color: Colors.yellowAccent,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox.shrink(),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _game = game();
                            _end = false;
                            _start = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.white, width: 1),
                        ),
                        child: Text('NEW GAME'))
                  ],
                )
        ],
      );
    } else {
      return Container(
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Im thinking of a number between 1 and 100.\n',
                style: GoogleFonts.mitr(
                    fontSize: 20.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.yellowAccent,
                        offset: Offset(1.0, 1.0),
                      ),
                    ]),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Can you guess it? ',
                    style: GoogleFonts.mitr(
                        fontSize: 20.0,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.pink,
                            offset: Offset(1.0, 1.0),
                          ),
                        ]),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Column _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/number.png',
          width: 150.0,
        ),
        Text(
          'GUESS THE NUMBER',
          style:
              GoogleFonts.mitr(fontSize: 15.0, color: Colors.white, shadows: [
            Shadow(
              blurRadius: 20.0,
              color: Colors.white,
              offset: Offset(1.0, 1.0),
            ),
          ]),
        ),
      ],
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF444444),
      appBar: AppBar(
        title: Text('GUESS THE NUMBER'),
        backgroundColor: Color(0xFF212121),
      ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                _buildMainContent(),
                _buildInputPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
