import 'dart:math';

import 'package:mathgame/src/models/quickCalculation/quickCalculationQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class QuickCalculationQandSDataProvider {
  static getQuickCalculationDataList(int level, int noItem) {
    List<QuickCalculationQandS> list = List();

    List<Expression> expressionList = MathUtil.generate(level, 5);
    expressionList.forEach((Expression expression) {
      list.add(QuickCalculationQandS(
          1,
          "${expression.firstOperand} ${expression.operator} ${expression.secondOperand}",
          expression.answer));
    });
    list.forEach((QuickCalculationQandS q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  QuickCalculationQandSDataProvider.getQuickCalculationDataList(1, 5);
}
