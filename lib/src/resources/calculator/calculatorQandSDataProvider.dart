import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class CalculatorQandSDataProvider {
  static getCalculatorDataList(int level) {
    List<CalculatorQandS> list = List();
    int i = 0;

    int min = 3;
    min = min < 1 ? 1 : min;
    int max = 10 + level;

    while (i < 5) {
      int x1 = MathUtil.generateRandomAnswer(min, max);
      String x2 = MathUtil.generateRandomSign();
      int x3 = MathUtil.generateRandomAnswer(min, max);
      if (MathUtil.evaluate(x1, x2, x3) >= 0 &&
          !list.contains(CalculatorQandS(
              1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)))) {
        if ((x2 == "/" && x1 > x3 && x1 % x3 == 0) || x2 != "/") {
          list.add(
              CalculatorQandS(1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)));
//          print("$x1 $x2 $x3 = ${MathUtil.evaluate(x1, x2, x3)}");
        }
        i++;
      }
    }

    for (int i = 0; i < list.length; i++) {
      var result = list.where((result) => result.question.contains("/"));
      if (!(result.length > 0)) {
        while (i < 2) {
          int x1 = MathUtil.generateRandomAnswer(min, max);
          String x2 = "/";
          int x3 = MathUtil.generateRandomAnswer(min, max);
          if ((MathUtil.evaluate(x1, x2, x3) >= 0 && x1 > x3 && x1 % x3 == 0)) {
            list.add(CalculatorQandS(
                1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)));
            print("$x1 $x2 $x3 = ${MathUtil.evaluate(x1, x2, x3)}");
            i++;
          }
        }
      }
    }
    list.shuffle();
    return list;
  }
}
