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
      default:
        return x1 ~/ x3;
    }
  }

  static bool isOperator(String sign) {
    return ["+", "-", "*", "/"].contains(sign);
  }

  // ignore: missing_return
  static int getPrecedence(String sign) {
    switch (sign) {
      case "+":
        return 1;
      case "-":
        return 1;
      case "*":
        return 2;
      default:
        return 3;
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

  static Expression getPlusSignExp(int min, int max) {
    var x = MathUtil.generateRandomNumber(min, max, 2);
    return Expression(
      firstOperand: x[0],
      operator1: "+",
      secondOperand: x[1],
      answer: int.parse(x[0]) + int.parse(x[1]),
      thirdOperand: '',
      operator2: null,
    );
  }

  static Expression getMinusSignExp(int min, int max) {
    var x1 = MathUtil.generateRandomNumber(max ~/ 2, max, 1);
    var x2 = MathUtil.generateRandomNumber(min, max, 1);
    while (int.parse(x2[0]) > int.parse(x1[0])) {
      x2 = MathUtil.generateRandomNumber(min, max, 1);
    }
    return Expression(
      firstOperand: x1[0],
      operator1: "-",
      secondOperand: x2[0],
      answer: int.parse(x1[0]) - int.parse(x2[0]),
      thirdOperand: '',
      operator2: null,
    );
  }

  static Expression getMultiplySignExp(int min, int max) {
    var x = MathUtil.generateRandomNumber(min, max, 2);

    return Expression(
      firstOperand: x[0],
      operator1: "*",
      secondOperand: x[1],
      answer: int.parse(x[0]) * int.parse(x[1]),
      thirdOperand: '',
      operator2: null,
    );
  }

  static Expression? getDivideSignExp(int min, int max) {
    var listTemp = <Map<String, String>>[];
    for (int i = min; i <= max; i++) {
      for (int j = min; j <= max; j++) {
        if (i != 1 && j != 1 && j != i && j % i == 0) {
          listTemp.add({j.toString(): i.toString()});
        }
      }
    }
    listTemp.shuffle();
    if (listTemp.length > 0) {
      var x = listTemp[Random().nextInt(listTemp.length)];
      return Expression(
        firstOperand: x.keys.first,
        operator1: "/",
        secondOperand: x.values.first,
        answer: int.parse(x.keys.first) ~/ int.parse(x.values.first),
        thirdOperand: '',
        operator2: null,
      );
    } else {
      return null;
    }
  }

  static Expression? getMixExp(int min, int max) {
    int operand = int.parse(MathUtil.generateRandomNumber(min, max, 1).first);
    var signList = MathUtil.generateRandomSign1(2);
    String firstSign = (MathUtil.getPrecedence(signList[0]) >=
            MathUtil.getPrecedence(signList[1]))
        ? signList[0]
        : "";
    String secondSign = (MathUtil.getPrecedence(signList[0]) >=
            MathUtil.getPrecedence(signList[1]))
        ? ""
        : signList[1];
    Expression? expression;
    Expression? finalExpression;

    switch (firstSign != "" ? firstSign : secondSign) {
      case "+":
        expression = MathUtil.getPlusSignExp(min, max);
        break;
      case "-":
        expression = MathUtil.getMinusSignExp(min, max);
        break;
      case "*":
        expression = MathUtil.getMultiplySignExp(1, 15);
        break;
      case "/":
        expression = MathUtil.getDivideSignExp(min, max);
        break;
    }
    if (expression != null) {
      switch (firstSign != "" ? signList[1] : signList[0]) {
        case "+":
          if (firstSign != "")
            finalExpression = Expression(
                firstOperand: expression.firstOperand,
                operator1: expression.operator1,
                secondOperand: expression.secondOperand,
                operator2: "+",
                thirdOperand: operand.toString(),
                answer: expression.answer + operand);
          else
            finalExpression = Expression(
                firstOperand: operand.toString(),
                operator1: "+",
                secondOperand: expression.firstOperand,
                operator2: expression.operator1,
                thirdOperand: expression.secondOperand,
                answer: operand + expression.answer);
          break;
        case "-":
          if (firstSign != "") {
            if ((expression.answer - operand) < 0) {
              finalExpression = null;
            } else {
              finalExpression = Expression(
                  firstOperand: expression.firstOperand,
                  operator1: expression.operator1,
                  secondOperand: expression.secondOperand,
                  operator2: "-",
                  thirdOperand: operand.toString(),
                  answer: expression.answer - operand);
            }
          } else {
            if ((operand - expression.answer) < 0) {
              finalExpression = null;
            } else {
              finalExpression = Expression(
                  firstOperand: operand.toString(),
                  operator1: "-",
                  secondOperand: expression.firstOperand,
                  operator2: expression.operator1,
                  thirdOperand: expression.secondOperand,
                  answer: operand - expression.answer);
            }
          }
          break;
        case "*":
          if (firstSign != "")
            finalExpression = Expression(
                firstOperand: expression.firstOperand,
                operator1: expression.operator1,
                secondOperand: expression.secondOperand,
                operator2: "*",
                thirdOperand: operand.toString(),
                answer: expression.answer * operand);
          else
            finalExpression = Expression(
                firstOperand: operand.toString(),
                operator1: "*",
                secondOperand: expression.firstOperand,
                operator2: expression.operator1,
                thirdOperand: expression.secondOperand,
                answer: operand * expression.answer);

          break;
        case "/":
          if (firstSign != "") {
            if (expression.answer % operand == 0) {
              finalExpression = null;
            } else {
              finalExpression = Expression(
                  firstOperand: expression.firstOperand,
                  operator1: expression.operator1,
                  secondOperand: expression.secondOperand,
                  operator2: "/",
                  thirdOperand: operand.toString(),
                  answer: expression.answer ~/ operand);
            }
          } else {
            if (operand % expression.answer == 0) {
              finalExpression = null;
            } else {
              finalExpression = Expression(
                  firstOperand: operand.toString(),
                  operator1: "/",
                  secondOperand: expression.firstOperand,
                  operator2: expression.operator1,
                  thirdOperand: expression.secondOperand,
                  answer: operand ~/ expression.answer);
            }
          }
          break;
      }
    } else {
      finalExpression = expression;
    }
    return finalExpression;
  }

  static Expression? getMentalExp(int level) {
    int min;
    int max;
    if (level <= 3) {
      min = level = 1;
      max = level = 10;
    } else if (level <= 6) {
      min = level = 5;
      max = level = 20;
    } else {
      min = level = 10;
      max = level = 30;
    }
    int operand = int.parse(MathUtil.generateRandomNumber(min, max, 1).first);
    var signList = MathUtil.generateRandomSign1(2);
    Expression? expression;
    Expression? finalExpression;

    switch (signList[0]) {
      case "+":
        expression = MathUtil.getPlusSignExp(min, max);
        break;
      case "-":
        expression = MathUtil.getMinusSignExp(min, max);
        break;
      case "*":
        expression = MathUtil.getMultiplySignExp(1, 15);
        break;
      case "/":
        expression = MathUtil.getDivideSignExp(min, max);
        break;
    }
    if (expression != null) {
      switch (signList[1]) {
        case "+":
          finalExpression = Expression(
              firstOperand: expression.firstOperand,
              operator1: expression.operator1,
              secondOperand: expression.secondOperand,
              operator2: signList[1],
              thirdOperand: operand.toString(),
              answer: operand + expression.answer);
          break;
        case "-":
          finalExpression = Expression(
              firstOperand: expression.firstOperand,
              operator1: expression.operator1,
              secondOperand: expression.secondOperand,
              operator2: signList[1],
              thirdOperand: operand.toString(),
              answer: expression.answer - operand);
          break;
        case "*":
          finalExpression = Expression(
              firstOperand: expression.firstOperand,
              operator1: expression.operator1,
              secondOperand: expression.secondOperand,
              operator2: signList[1],
              thirdOperand: operand.toString(),
              answer: expression.answer * operand);

          break;
        case "/":
          if (expression.answer % operand != 0) {
            finalExpression = null;
          } else {
            finalExpression = Expression(
                firstOperand: expression.firstOperand,
                operator1: expression.operator1,
                secondOperand: expression.secondOperand,
                operator2: signList[1],
                thirdOperand: operand.toString(),
                answer: expression.answer ~/ operand);
          }
          break;
      }
    } else {
      finalExpression = expression;
    }
    return finalExpression;
  }

  static List<Expression> getMathPair(int level, int count) {
    var list = <Expression>[];
    int min = level == 1 ? 1 : (5 * level) - 5; //1 5 10 15 20 25
    int max = level == 1 ? 10 : (10 * level); //10 20 30 40 50 60
    while (list.length < count) {
      MathUtil.generateRandomSign1(count - list.length).forEach((String sign) {
        Expression? expression;
        if (level <= 2) {
          switch (sign) {
            case "+":
              expression = MathUtil.getPlusSignExp(min, max);
              break;
            case "-":
              expression = MathUtil.getMinusSignExp(min, max);
              break;
            case "*":
              expression = MathUtil.getMultiplySignExp(1, 10);
              break;
            case "/":
              expression = MathUtil.getDivideSignExp(1, 10);
              break;
          }
        } else if (level <= 3) {
          switch (sign) {
            case "+":
              expression = MathUtil.getPlusSignExp(min, max);
              break;
            case "-":
              expression = MathUtil.getMinusSignExp(min, max);
              break;
            case "*":
              expression = MathUtil.getMultiplySignExp(1, 15);
              break;
            case "/":
              expression = MathUtil.getDivideSignExp(1, 15);
              break;
          }
        } else {
          switch (sign) {
            case "+":
              expression = MathUtil.getPlusSignExp(min, max);
              break;
            case "-":
              expression = MathUtil.getMinusSignExp(min, max);
              break;
            case "*":
              expression = MathUtil.getMultiplySignExp(5, 30);
              break;
            case "/":
              expression = MathUtil.getDivideSignExp(5, 30);
              break;
          }
        }
        if (expression != null && !list.contains(expression)) {
          list.add(expression);
        }
      });
    }
    return list;
  }

  static List<Expression> generate(int level, int count) {
    var list = <Expression>[];
    int min = level == 1 ? 1 : (5 * level) - 5; //1 5 10 15 20 25
    int max = level == 1 ? 10 : (10 * level); //10 20 30 40 50 60
    while (list.length < count) {
      MathUtil.generateRandomSign1(count - list.length).forEach((String sign) {
        Expression? expression;
        if (level <= 2) {
          switch (sign) {
            case "+":
              expression = MathUtil.getPlusSignExp(min, max);
              break;
            case "-":
              expression = MathUtil.getMinusSignExp(min, max);
              break;
            case "*":
              expression = MathUtil.getMultiplySignExp(1, 15);
              break;
            case "/":
              expression = MathUtil.getDivideSignExp(min, max);
              break;
          }
        } else if (level <= 4) {
          switch (sign) {
            case "+":
              expression = MathUtil.getPlusSignExp(min, max);
              break;
            case "-":
              expression = MathUtil.getMinusSignExp(min, max);
              break;
            case "*":
              expression = MathUtil.getMixExp(1, 15);
              break;
            case "/":
              expression = MathUtil.getDivideSignExp(min, max);
              break;
          }
        } else if (level < 5) {
          expression = MathUtil.getMixExp(1, 25);
        } else if (level < 6) {
          expression = MathUtil.getMixExp(1, 30);
        } else {
          expression = MathUtil.getMixExp(1, 50);
        }
        if (expression != null && !list.contains(expression)) {
          list.add(expression);
        }
      });
    }
    return list;
  }
}

void main() {

}

class Expression {
  final String firstOperand;
  final String operator1;
  final String secondOperand;
  final String? operator2;
  final String thirdOperand;
  final int answer;

  Expression({
    required this.firstOperand,
    required this.operator1,
    required this.secondOperand,
    required this.operator2,
    required this.thirdOperand,
    required this.answer,
  });

  @override
  String toString() {
    return 'Expression{firstOperand: $firstOperand, operator1: $operator1, secondOperand: $secondOperand, operator2: $operator2, thirdOperand: $thirdOperand, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Expression &&
          runtimeType == other.runtimeType &&
          firstOperand == other.firstOperand &&
          operator1 == other.operator1 &&
          secondOperand == other.secondOperand &&
          operator2 == other.operator2 &&
          thirdOperand == other.thirdOperand &&
          answer == other.answer;

  @override
  int get hashCode =>
      firstOperand.hashCode ^
      operator1.hashCode ^
      secondOperand.hashCode ^
      operator2.hashCode ^
      thirdOperand.hashCode ^
      answer.hashCode;
}
