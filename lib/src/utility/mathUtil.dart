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

  static List<String> generateRandomNumber(int min, int max, int count) {
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
      int row = Random().nextInt(max - min);
      int col = Random().nextInt(max - min);
      if (listOfSign.length == 0 ||
          list[row][col].toString() != listOfSign.last)
        listOfSign.add(list[row][col].toString());
    }
    return listOfSign;
  }

  static Expression getPlushSignExp(int min, int max) {
    var x = MathUtil.generateRandomNumber(min, max, 2);
    return Expression(
        firstOperand: x[0],
        operator: "+",
        secondOperand: x[1],
        answer: int.tryParse(x[0]) + int.tryParse(x[1]));
  }

  static Expression getMinisSignExp(int min, int max) {
    var x1 = MathUtil.generateRandomNumber(min + 1, max, 1);
    var x2 = MathUtil.generateRandomNumber(min, max, 1);
    while (int.tryParse(x2[0]) > int.tryParse(x1[0])) {
      x2 = MathUtil.generateRandomNumber(min, max, 1);
    }
    return Expression(
        firstOperand: x1[0],
        operator: "-",
        secondOperand: x2[0],
        answer: int.tryParse(x1[0]) - int.tryParse(x2[0]));
  }

  static Expression getMultiplySignExp(int min, int max) {
    var x = MathUtil.generateRandomNumber(min, max, 2);

    return Expression(
        firstOperand: x[0],
        operator: "*",
        secondOperand: x[1],
        answer: int.tryParse(x[0]) * int.tryParse(x[1]));
  }

  static Expression getDivedSignExp(int min, int max) {
    var listTemp = <Map<String, String>>[];
    for (int i = min; i <= max; i++) {
      for (int j = min; j <= max; j++) {
        if (i != 1 && j != 1 && j != i && j % i == 0) {
          listTemp.add({j.toString(): i.toString()});
        }
      }
    }
    listTemp.shuffle();
    var x = listTemp[Random().nextInt(listTemp.length)];
    return Expression(
        firstOperand: x.keys.first,
        operator: "/",
        secondOperand: x.values.first,
        answer: int.tryParse(x.keys.first) ~/ int.tryParse(x.values.first));
  }

  static List<Expression> generate(int level, int count) {
    var list = <Expression>[];
    int min = level == 1 ? 1 : (5 * level) - 5;
    int max = level == 1 ? 10 : (10 * level) ;
    print("$min $max");
    while (list.length < count) {
      MathUtil.generateRandomSign1(count - list.length).forEach((String sign) {
        Expression expression;
        switch (sign) {
          case "+":
            expression = MathUtil.getPlushSignExp(min, max);
            break;
          case "-":
            expression = MathUtil.getMinisSignExp(min, max);
            break;
          case "*":
            expression = MathUtil.getMultiplySignExp(min, max);
            break;
          case "/":
            expression = MathUtil.getDivedSignExp(min, max);
            break;
        }
        if (!list.contains(expression)) {
          list.add(expression);
        }
      });
    }
    return list;
  }
}

void main() {
//  for (int i = 0; i < 10; i++) {
  MathUtil.generate(5, 5);
//  print("${MathUtil.generateRandomSign1(5)}");
//  }
}

class Expression {
  String firstOperand;
  String operator;
  String secondOperand;
  int answer;

  Expression(
      {this.firstOperand, this.operator, this.secondOperand, this.answer});

  @override
  String toString() {
    return 'Expression{firstOperand: $firstOperand, operator: $operator, secondOperand: $secondOperand, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Expression &&
          runtimeType == other.runtimeType &&
          firstOperand == other.firstOperand &&
          operator == other.operator &&
          secondOperand == other.secondOperand &&
          answer == other.answer;

  @override
  int get hashCode =>
      firstOperand.hashCode ^
      operator.hashCode ^
      secondOperand.hashCode ^
      answer.hashCode;
}
