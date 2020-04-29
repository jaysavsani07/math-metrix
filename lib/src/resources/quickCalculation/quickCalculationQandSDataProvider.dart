import 'package:mathgame/src/models/quickCalculation/quickCalculationQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class QuickCalculationQandSDataProvider {
  static getQuickCalculationDataList(int level, int noItem) {
    List<QuickCalculationQandS> list = List();

    int i = 0;

    int min = 3;
    min = min < 1 ? 1 : min;
    int max = 10;

    while (i < noItem) {
      int x1 = MathUtil.generateRandomAnswer(min, max);
      String x2 = MathUtil.generateRandomSign();
      int x3 = MathUtil.generateRandomAnswer(min, max);
      if (MathUtil.evaluate(x1, x2, x3) > 0 &&
          !list.contains(QuickCalculationQandS(
              1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)))) {
        if ((x2 == "/" && x1 > x3 && x1 % x3 == 0) || x2 != "/") {
          list.add(QuickCalculationQandS(
              1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)));
          print("$x1 $x2 $x3 = ${MathUtil.evaluate(x1, x2, x3)}");
          i++;
        }
      }
    }
    for (int i = 0; i < list.length; i++) {
      var result = list.where((result) => result.question.contains("/"));
      if (!(result.length > 0)) {
        while (i < 2) {
          int x1 = MathUtil.generateRandomAnswer(min, max);
          String x2 = "/";
          int x3 = MathUtil.generateRandomAnswer(min, max);
          if (MathUtil.evaluate(x1, x2, x3) > 0 &&
              !list.contains(QuickCalculationQandS(
                  1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)))) {
            if ((x2 == "/" && x1 > x3 && x1 % x3 == 0) || x2 != "/") {
              list.add(QuickCalculationQandS(
                  1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)));
              print("$x1 $x2 $x3 = ${MathUtil.evaluate(x1, x2, x3)}");
              i++;
            }
          }
        }
      }
    }
    list.shuffle();

    return list;
  }


}

void main() {
  QuickCalculationQandSDataProvider.getQuickCalculationDataList(1, 5);
}
