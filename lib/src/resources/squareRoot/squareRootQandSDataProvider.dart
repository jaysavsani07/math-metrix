import 'package:mathgame/src/models/squareRoot/SquareRootQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class SquareRootQandSDataProvider {
  static List<int> listHasCode = List();

  static getSquareDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }
    List<SquareRootQandS> list = List();

    int min = level == 1 ? 1 : (5 * level) - 5;  //1  5  10 15 20 25
    int max = level == 1 ? 10 : (5 * level) + 5; //10 15 20 25 30 35
    while (list.length < 5) {
      MathUtil.generateRandomNumber(min, max, 5 - list.length)
          .map((String x1) => int.parse(x1))
          .forEach((int x1) {
        List<int> operandList = List();
        operandList.add(x1);
        while (operandList.length < 4) {
          int operand =
              MathUtil.generateRandomAnswer((x1 - 5) < 1 ? 2 : x1 - 5, x1 + 5);
          if (!operandList.contains(operand)) operandList.add(operand);
        }

        operandList.shuffle();
        SquareRootQandS squareRootQandS = SquareRootQandS(
            (x1 * x1).toString(),
            operandList[0].toString(),
            operandList[1].toString(),
            operandList[2].toString(),
            operandList[3].toString(),
            x1);
        if (!listHasCode.contains(squareRootQandS.hashCode)) {
          listHasCode.add(squareRootQandS.hashCode);
          list.add(squareRootQandS);
          print("$x1    ${x1 * x1} ${operandList.toString()}");
        }
      });
    }
    return list;
  }
}

void main() {
  for (int i = 1; i < 5; i++) {
    print(
        "**********$i***********${SquareRootQandSDataProvider.listHasCode.length}");
    SquareRootQandSDataProvider.getSquareDataList(i);
  }
}
