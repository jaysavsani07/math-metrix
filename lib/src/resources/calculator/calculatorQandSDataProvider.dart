import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class CalculatorQandSDataProvider {
  static getCalculatorDataList(int level) {
    List<CalculatorQandS> list = List();

    List<Expression> expressionList = MathUtil.generate(level, 5);
    expressionList.forEach((Expression expression) {
      list.add(CalculatorQandS(
          1,
          "${expression.firstOperand} ${expression.operator} ${expression.secondOperand}",
          expression.answer));
    });

    list.forEach((CalculatorQandS q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  for (int i = 1; i <= 5; i++) {
    CalculatorQandSDataProvider.getCalculatorDataList(i);
    print("**************");
  }
}
