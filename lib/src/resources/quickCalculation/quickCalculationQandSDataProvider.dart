import 'package:mathgame/src/models/quickCalculation/quickCalculationQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class QuickCalculationQandSDataProvider {
  static List<int> listHasCode = List();

  static getQuickCalculationDataList(int level, int noItem) {
    if (level == 1) {
      listHasCode.clear();
    }
    List<QuickCalculationQandS> list = List();

    while (list.length < noItem) {
      MathUtil.generate(level, noItem - list.length)
          .forEach((Expression expression) {
        QuickCalculationQandS quickCalculationQandS;
        if (expression.operator2 == null) {
          quickCalculationQandS = QuickCalculationQandS(
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
              expression.answer);
        } else {
          quickCalculationQandS = QuickCalculationQandS(
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
              expression.answer);
        }
        if (!listHasCode.contains(quickCalculationQandS.hashCode)) {
          listHasCode.add(quickCalculationQandS.hashCode);
          list.add(quickCalculationQandS);
        }
      });
    }

    list.forEach((QuickCalculationQandS q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  for (int i = 1; i <= 5; i++) {
    QuickCalculationQandSDataProvider.getQuickCalculationDataList(i, 1);
    print("**************");
  }
}
