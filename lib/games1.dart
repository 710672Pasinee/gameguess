import 'dart:math';


class Game {
  late int answer;
  List numlist = [];
  int totalGuesses = 0;

  int getTotalGuesses() {
    return totalGuesses;
  }

  Game() {
    this.answer = Random().nextInt(100) + 1;
  }

  doGuess(int num) {
    totalGuesses++;
    numlist.add(num);
    if (num < this.answer) {
      return -1;
    } else if (num > this.answer) {
      return 1;
    } else {
      return 0;
    }
  }

  String topath() {
    String str = "";
    for (int i = 0; i < numlist.length; ++i) {
      str += numlist[i].toString();
      if (i + 1 != numlist.length)
        str += " -> ";
    }
    return str;
  }
}

