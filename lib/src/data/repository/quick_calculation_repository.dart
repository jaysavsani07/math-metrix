import 'package:mathgame/src/data/models/quick_calculation.dart';
import 'package:mathgame/src/utility/math_util.dart';

class QuickCalculationRepository {
  static List<int> listHasCode = <int>[];

  static getQuickCalculationDataList(int level, int noItem) {
    if (level == 1) {
      listHasCode.clear();
    }
    List<QuickCalculation> list = <QuickCalculation>[];

    while (list.length < noItem) {
      MathUtil.generate(level, noItem - list.length)
          .forEach((Expression expression) {
        QuickCalculation quickCalculationQandS;
        if (expression.operator2 == null) {
          quickCalculationQandS = QuickCalculation(
            question:
                "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
            answer: expression.answer,
          );
        } else {
          quickCalculationQandS = QuickCalculation(
            question:
                "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}",
            answer: expression.answer,
          );
        }
        if (!listHasCode.contains(quickCalculationQandS.hashCode)) {
          listHasCode.add(quickCalculationQandS.hashCode);
          list.add(quickCalculationQandS);
        }
      });
    }

    return list;
  }
}

void main() {
  for (int i = 1; i <= 5; i++) {
    QuickCalculationRepository.getQuickCalculationDataList(i, 1);
  }
}
