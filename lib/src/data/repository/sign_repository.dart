import 'package:mathgame/src/data/models/sign.dart';
import 'package:mathgame/src/utility/math_util.dart';

class SignRepository {
  static List<int> listHasCode = <int>[];

  static getSignDataList(int level) {
    List<Sign> list = <Sign>[];

    if (level == 1) {
      listHasCode.clear();
    }
    while (list.length < 5) {
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        Sign? signQandS;
        if (expression.operator2 == null) {
          if (expression.operator1 == "+") {
            if (MathUtil.evaluate(int.parse(expression.firstOperand), "+",
                    int.parse(expression.secondOperand)) !=
                MathUtil.evaluate(int.parse(expression.firstOperand), "*",
                    int.parse(expression.secondOperand))) {
              signQandS = Sign(
                firstDigit: expression.firstOperand,
                sign: expression.operator1,
                secondDigit: expression.secondOperand,
                answer: expression.answer.toString(),
              );
            }
          } else if (expression.operator1 == "/") {
            if (MathUtil.evaluate(int.parse(expression.firstOperand), "/",
                    int.parse(expression.secondOperand)) !=
                MathUtil.evaluate(int.parse(expression.firstOperand), "-",
                    int.parse(expression.secondOperand))) {
              signQandS = Sign(
                firstDigit: expression.firstOperand,
                sign: expression.operator1,
                secondDigit: expression.secondOperand,
                answer: expression.answer.toString(),
              );
            }
          } else {
            signQandS = Sign(
              firstDigit: expression.firstOperand,
              sign: expression.operator1,
              secondDigit: expression.secondOperand,
              answer: expression.answer.toString(),
            );
          }
        } else {
          signQandS = Sign(
            firstDigit: list.length % 2 == 0
                ? ("${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}")
                : (expression.firstOperand),
            sign: list.length % 2 == 0
                ? expression.operator2!
                : expression.operator1,
            secondDigit: list.length % 2 == 0
                ? expression.thirdOperand
                : ("${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}"),
            answer: expression.answer.toString(),
          );
        }
        if (signQandS != null) {
          if (!listHasCode.contains(signQandS.hashCode)) {
            listHasCode.add(signQandS.hashCode);
            list.add(signQandS);
          }
        }
      });
    }
    return list;
  }
}

void main() {
  for (int i = 1; i <= 5; i++) {
    print(SignRepository.getSignDataList(i));
  }
}
