import 'dart:math';

class Game {
  final int _answer;
  int _totalGuesses = 0 ;
  List<int> _historyInput = [];


  Game() : _answer = Random().nextInt(100) + 1 {
    print("The answer is: $_answer");
  }


  int getTotalGuesses(){
    return _totalGuesses;
  }

  String getAnswer(){
    return _answer.toString();
  }

  List<int> getHistoryInput(){
    print(_historyInput);
    return _historyInput;
  }



  int doGuess(int num) {
    _historyInput.add(num);
    _totalGuesses++;
    if(num > _answer) {
      return 1;
    } else if(num < _answer) {
      return -1;
    } else {
      return 0;
    }
  }

}