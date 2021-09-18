import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/Game/Game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Game _game;
  var input = '';
  final _controller = TextEditingController();
  bool _start = false;
  bool _end = false;
  String _feedback = '';

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

  //Widget _buildInputPanel() {return }

  Widget _buildInputPanel() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              decoration: InputDecoration(
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
            onPressed: () {
              setState(() {
                _start = true;
                input = _controller.text;
                int? guess = int.tryParse(input);
                if (guess != null) {
                  var result = _game.doGuess(guess);
                  if (result == 0) {
                    _feedback = 'CORRECT';
                    _end = true;
                  } else if (result == 1) {
                    _feedback = 'TOO HIGH!';
                  } else {
                    _feedback = 'TOO LOW!';
                  }
                }
                _controller.clear();
              });
            },
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
                    _game = Game();
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
