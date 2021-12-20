import 'package:mathgame/src/data/models/quick_calculation.dart';
import 'package:mathgame/src/utility/math_util.dart';

class QuickCalculationRepository {
  static List<int> listHasCode = List();

  static getQuickCalculationDataList(int level, int noItem) {
    if (level == 1) {
      listHasCode.clear();
    }
    List<QuickCalculation> list = List();

    while (list.length < noItem) {
      MathUtil.generate(level, noItem - list.length)
          .forEach((Expression expression) {
        QuickCalculation quickCalculationQandS;
        if (expression.operator2 == null) {
          quickCalculationQandS = QuickCalculation(
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
              expression.answer);
        } else {
          quickCalculationQandS = QuickCalculation(
              "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
              expression.answer);
        }
        if (!listHasCode.contains(quickCalculationQandS.hashCode)) {
          listHasCode.add(quickCalculationQandS.hashCode);
          list.add(quickCalculationQandS);
        }
      });
    }

    list.forEach((QuickCalculation q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  for (int i = 1; i <= 5; i++) {
    QuickCalculationRepository.getQuickCalculationDataList(i, 1);
    print("**************");
  }
}
