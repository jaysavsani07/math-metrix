import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class CalculatorQandSDataProvider {
  static getCalculatorDataList(int level) {
    List<CalculatorQandS> list = List();

    int min = level == 1 ? 1 : (5 * level) - 5;
    int max = level == 1 ? 10 : (5 * level) + 5;
    print("$min $max");
    int i = 0;
    var x1 = MathUtil.generate(min, max, 10);
    var x2 = MathUtil.generateRandomSign1(10);
    var x3 = MathUtil.generate(min, max, 10);
    while (list.length < 5 && i < 10) {
      if (MathUtil.evaluate(int.parse(x1[i]), x2[i], int.parse(x3[i])) >= 0 &&
          !list.contains(CalculatorQandS(1, "${x1[i]} ${x2[i]} ${x3[i]}",
              MathUtil.evaluate(int.parse(x1[i]), x2[i], int.parse(x3[i]))))) {
        if ((x2[i] == "/" && int.parse(x1[i]) % int.parse(x3[i]) == 0) ||
            x2[i] != "/") {
          list.add(CalculatorQandS(1, "${x1[i]} ${x2[i]} ${x3[i]}",
              MathUtil.evaluate(int.parse(x1[i]), x2[i], int.parse(x3[i]))));
          print(
              "${x1[i]} ${x2[i]} ${x3[i]} ${MathUtil.evaluate(int.parse(x1[i]), x2[i], int.parse(x3[i]))}");
        }
      }
      i++;
    }
    return list;
  }
}

void main() {
  for (int i = 1; i <= 5; i++) {
    CalculatorQandSDataProvider.getCalculatorDataList(i);
    print("**************");
  }
}
