import 'dart:math';

class MathUtil {
  static int evaluate(int x1, String sign, int x3) {
    switch (sign) {
      case "+":
        return x1 + x3;
      case "-":
        return x1 - x3;
      case "*":
        return x1 * x3;
      case "/":
        return x1 ~/ x3;
    }
  }

  static int generateRandomAnswer(int min, int max) {
    final _random = new Random();
    int result = min + _random.nextInt(max - min);
    return result;
  }

  static String generateRandomSign() {
    var x = ['/', '*', '-', '+'];
    final _random = new Random();
    int result = _random.nextInt(4);
    return x[result];
  }

  static List<String> generateRandomSign1(int count) {
    var listOfSign = <String>[];
    var list = [
      ['/', '*', '-', '+'],
      ['/', '*', '-', '+'],
      ['/', '*', '-', '+'],
      ['/', '*', '-', '+']
    ];

    while (listOfSign.length < count) {
      int row = Random().nextInt(4);
      int col = Random().nextInt(4);
      if (listOfSign.length == 0 || list[row][col] != listOfSign.last)
        listOfSign.add(list[row][col]);
    }
    return listOfSign;
  }

  static List<String> generate(int min, int max, int count) {
    var list = <List<int>>[];
    var listOfSign = <String>[];
    var listTemp = <int>[];

    for (int i = min; i <= max; i++) {
      listTemp.add(i);
    }
    for (int i = min; i <= max; i++) {
      list.add(listTemp);
    }
    while (listOfSign.length < count) {
      int row = Random().nextInt(9);
      int col = Random().nextInt(9);
      if (listOfSign.length == 0 ||
          list[row][col].toString() != listOfSign.last)
        listOfSign.add(list[row][col].toString());
    }
    return listOfSign;
  }
}

void main() {
//  for (int i = 0; i < 10; i++) {
  print("${MathUtil.generateRandomSign1(5)}");
//  }
}
