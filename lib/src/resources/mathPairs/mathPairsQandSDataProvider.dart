import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class MathPairsQandSDataProvider {
  static getMathPairsDataList(int level) {
    List<MathPairsQandS> list = List();

    int i = 0;
    int min = 3;
    min = min < 1 ? 1 : min;
    int max = 10;

    List<MathPair> x = List();
    while (x.length < 12) {
      int x1 = MathUtil.generateRandomAnswer(min, max);
      String x2 = MathUtil.generateRandomSign();
      int x3 = MathUtil.generateRandomAnswer(min, max);
      if (MathUtil.evaluate(x1, x2, x3) > 0 &&
          !list.contains(MathPair(1, "$x1 $x2 $x3", false, true))) {
        if ((x2 == "/" && x1 > x3 && x1 % x3 == 0) || x2 != "/") {
          x.add(MathPair(i, "$x1 $x2 $x3", false, true));
          x.add(MathPair(i, "${MathUtil.evaluate(x1, x2, x3)}", false, true));
        }
        i++;
      }
    }
    x.shuffle();
    print(x.toString());
    list.add(MathPairsQandS(2, x, 12));

    return list;
  }
}

void main() {
  for (int i = 1; i < 2; i++) {
    MathPairsQandSDataProvider.getMathPairsDataList(1);
  }
}
