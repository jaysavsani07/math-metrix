import 'package:mathgame/src/data/models/math_pairs.dart';
import 'package:mathgame/src/utility/math_util.dart';

class MathPairsRepository {
  static List<int> listHasCode = <int>[];

  static getMathPairsDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    int i = 0;
    int totalPairs = level <= 2 ? 12 : 18;

    List<Pair> list = <Pair>[];

    while (list.length < totalPairs) {
      MathUtil.getMathPair(level, (totalPairs ~/ 2) - (list.length ~/ 2))
          .forEach((Expression expression) {
        Pair mathPair1 = Pair(
            i,
            "${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}",
            false,
            true);
        Pair mathPair2 = Pair(i, "${expression.answer}", false, true);
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
    return <MathPairs>[MathPairs(list, totalPairs)];
  }
}

void main() {
  for (int i = 1; i < 6; i++) {
    MathPairsRepository.getMathPairsDataList(i);
  }
}
