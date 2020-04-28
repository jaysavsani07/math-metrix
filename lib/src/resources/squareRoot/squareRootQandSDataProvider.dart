import 'package:mathgame/src/models/squareRoot/SquareRootQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class SquareRootQandSDataProvider {
  static getSquareDataList(int level) {
    List<SquareRootQandS> list = List();

    int i = 0;
    int min = 2 ;
    min = min < 1 ? 1 : min;
    int max = 13 + level;

    print("level $level");

    while (i < 5) {
      int x1 = MathUtil.generateRandomAnswer(min, max);
      List<int> x = List();
      x.add(x1);
      while (x.length < 4) {
        int x2 =
            MathUtil.generateRandomAnswer((x1 - 5) < 0 ? 1 : x1 - 5, x1 + 5);
        if (!x.contains(x2)) x.add(x2);
      }

      x.shuffle();
      if (!list.contains(SquareRootQandS(
          1,
          (x1 * x1).toString(),
          x[0].toString(),
          x[1].toString(),
          x[2].toString(),
          x[3].toString(),
          x1))) {
        list.add(SquareRootQandS(1, (x1 * x1).toString(), x[0].toString(),
            x[1].toString(), x[2].toString(), x[3].toString(), x1));
        print("$x1 ${x1 * x1} ${x.toString()}");
        i++;
      }
    }

    return list;
  }
}

void main() {
  for (int i = 0; i < 5; i++) {
    SquareRootQandSDataProvider.getSquareDataList(1);
  }
}
