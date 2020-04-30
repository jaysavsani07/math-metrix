import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class MathPairsQandSDataProvider {
  static getMathPairsDataList(int level) {
    List<MathPairsQandS> list = List();

    int i = 0;
    int min = 3;
    min = min < 1 ? 1 : min;
    int max = 10;
    int totalPairs = level <= 2 ? 12 : 18;
    print("level $level   total pairs $totalPairs");

    List<MathPair> x = List();
    while (x.length < totalPairs) {
      int firstNo = 0;
      int secondNo = 0;
      String sign = MathUtil.generateRandomSign();

      if (sign == "/" || sign == "*") {
        firstNo = MathUtil.generateRandomAnswer(min, max);
        secondNo = MathUtil.generateRandomAnswer(min, max);
      } else {
        firstNo = MathUtil.generateRandomAnswer(min, 100);
        secondNo = MathUtil.generateRandomAnswer(min, 100);
      }

      if (MathUtil.evaluate(firstNo, sign, secondNo) > 0 &&
          !x.contains(MathPair(1, "$firstNo $sign $secondNo", false, true)) &&
          !x.contains(MathPair(1,
              "${MathUtil.evaluate(firstNo, sign, secondNo)}", false, true))) {
        if ((sign == "/" && firstNo > secondNo && firstNo % secondNo == 0) ||
            sign != "/") {
          x.add(MathPair(i, "$firstNo $sign $secondNo", false, true));
          x.add(MathPair(
              i, "${MathUtil.evaluate(firstNo, sign, secondNo)}", false, true));
        }
        i++;
      }
    }
    x.shuffle();
    list.add(MathPairsQandS(2, x, totalPairs));
    list.forEach((MathPairsQandS m) {
      m.list.forEach((MathPair m1) {
        print(m1.text);
      });
    });
    return list;
  }
}

void main() {
  for (int i = 1; i < 2; i++) {
    MathPairsQandSDataProvider.getMathPairsDataList(1);
  }
}
