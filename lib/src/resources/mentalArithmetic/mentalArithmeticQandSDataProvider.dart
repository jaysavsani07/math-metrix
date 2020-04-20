import 'package:mathgame/src/models/mentalArithmetic/mentalArithmeticQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class MentalArithmeticQandSDataProvider {
  static getMentalArithmeticDataList() {
    List<MentalArithmeticQandS> list = List();

    list.add(MentalArithmeticQandS(1, ["5", "-1", "*5", ""], 20));
    list.add(MentalArithmeticQandS(2, ["5", "/5", "+1", ""], 2));
    list.add(MentalArithmeticQandS(3, ["11", "-6", "*2", ""], 10));
    list.add(MentalArithmeticQandS(4, ["-5", "-6", "+1", ""], -10));

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
      if (!list.contains(MentalArithmeticQandS(
          1, [x1.toString(), "$x2$x3", "$x4$x5", ""], x))) {
        if ((x2 == "/" && x1 > x3 && x1 % x3 == 0) || x2 != "/") {
          list.add(MentalArithmeticQandS(
              1, [x1.toString(), "$x2$x3", "$x4$x5", ""], x));
        }
        i++;
      }
    }
    return list;
  }
}
