import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class CalculatorQandSDataProvider {
  static List<int> listHasCode = List();

  static getCalculatorDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<CalculatorQandS> list = List();

    while (list.length < 5) {
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        CalculatorQandS calculatorQandS;
        if (expression.operator2 == null) {
          calculatorQandS = CalculatorQandS(
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
              expression.answer);
        } else {
          calculatorQandS = CalculatorQandS(
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
              expression.answer);
        }
        if (!listHasCode.contains(calculatorQandS.hashCode)) {
          listHasCode.add(calculatorQandS.hashCode);
          list.add(calculatorQandS);
        }
      });
    }

    list.forEach((CalculatorQandS q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  for (int i = 1; i <= 7; i++) {
    CalculatorQandSDataProvider.getCalculatorDataList(i);
    print("**************");
  }
}
