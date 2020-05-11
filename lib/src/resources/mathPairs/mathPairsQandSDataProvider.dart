import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class MathPairsQandSDataProvider {
  static List<int> listHasCode = List();

  static List<MathPairsQandS> getMathPairsDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    int i = 0;
    int totalPairs = level <= 2 ? 12 : 18;
    print("level $level   total pairs $totalPairs");

    List<MathPair> list = List();

    while (list.length < totalPairs) {
      MathUtil.getMathPair(level, (totalPairs ~/ 2) - (list.length ~/ 2))
          .forEach((Expression expression) {
        MathPair mathPair1 = MathPair(
            i,
            "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
            false,
            true);
        MathPair mathPair2 = MathPair(i, "${expression.answer}", false, true);
        if (!list.contains(mathPair2) &&
            !listHasCode.contains(mathPair1.hashCode)) {
          list.add(mathPair1);
          list.add(mathPair2);
          listHasCode.add(mathPair1.hashCode);
          i++;
        }
      });
    }

    list.shuffle();
    return [MathPairsQandS(list, totalPairs)];
  }
}

void main() {
  for (int i = 1; i < 6; i++) {
    MathPairsQandSDataProvider.getMathPairsDataList(i);
  }
}
