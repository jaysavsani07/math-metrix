import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class CalculatorQandSDataProvider {
  static getCalculatorDataList(int level) {
    List<CalculatorQandS> list = List();
    int i = 0;

    int min = 10;
    min = min < 1 ? 1 : min;
    int max = 20;

    while (i < 5) {
      int x1 = MathUtil.generateRandomAnswer(min, max);
      String x2 = MathUtil.generateRandomSign();
      int x3 = MathUtil.generateRandomAnswer(min, max);

      if (x1 % x3 == 0 && MathUtil.evaluate(x1, x2, x3)>0 &&
          !list.contains(CalculatorQandS(
              1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)))) {

        print("$x1 $x2 $x3 = ${MathUtil.evaluate(x1, x2, x3)}");

        list.add(
            CalculatorQandS(1, "$x1 $x2 $x3", MathUtil.evaluate(x1, x2, x3)));
        i++;
      }
    }

    return list;
  }
}

void main() {
  for (int i = 1; i < 6; i++) {
    CalculatorQandSDataProvider.getCalculatorDataList(i);
  }
}
