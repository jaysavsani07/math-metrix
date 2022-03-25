import 'package:mathgame/src/data/models/calculator.dart';
import 'package:mathgame/src/utility/math_util.dart';

class CalculatorRepository {
  static List<int> listHasCode = <int>[];

  static getCalculatorDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<Calculator> list = <Calculator>[];

    while (list.length < 5) {
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        Calculator calculatorQandS;
        if (expression.operator2 == null) {
          calculatorQandS = Calculator(
              question:
                  "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
              answer: expression.answer);
        } else {
          calculatorQandS = Calculator(
              question:
                  "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
              answer: expression.answer);
        }
        if (!listHasCode.contains(calculatorQandS.hashCode)) {
          listHasCode.add(calculatorQandS.hashCode);
          list.add(calculatorQandS);
        }
      });
    }
    return list;
  }
}

void main() {
  for (int i = 1; i <= 7; i++) {
    CalculatorRepository.getCalculatorDataList(i);
  }
}
