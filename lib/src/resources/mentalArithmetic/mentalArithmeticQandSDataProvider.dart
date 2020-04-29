import 'package:mathgame/src/models/mentalArithmetic/mentalArithmeticQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class MentalArithmeticQandSDataProvider {
  static getMentalArithmeticDataList(int level) {
    List<MentalArithmeticQandS> list = List();

    int i = 0;

    int min = 3;
    min = min < 1 ? 1 : min;
    int max = 10;

    while (i < 5) {
      int x1 = MathUtil.generateRandomAnswer(min, max);
      String x2 = MathUtil.generateRandomSign();
      int x3 = MathUtil.generateRandomAnswer(min, max);
      String x4 = MathUtil.generateRandomSign();
      int x5 = MathUtil.generateRandomAnswer(min, max);
      int x = MathUtil.evaluate(MathUtil.evaluate(x1, x2, x3), x4, x5);
      if ("$x2$x3" != "$x4$x5" &&
          !list.contains(MentalArithmeticQandS(
              1, [x1.toString(), "$x2$x3", "$x4$x5", ""], x))) {
        if (((x2 == "/" && x3 != 0 && x1 % x3 == 0) || x2 != "/") &&
            ((x4 == "/" &&
                    x5 != 0 &&
                    MathUtil.evaluate(x1, x2, x3) % x5 == 0) ||
                x4 != "/")) {
          list.add(MentalArithmeticQandS(
              1, [x1.toString(), "$x2$x3", "$x4$x5", ""], x));
          print("$x1 $x2$x3 $x4$x5 = $x");
        }
        i++;
      }
    }
    return list;
  }
}

void main() {
  for (int i = 0; i < 10; i++) {
    MentalArithmeticQandSDataProvider.getMentalArithmeticDataList(1);
  }
}
