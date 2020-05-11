import 'package:mathgame/src/models/mentalArithmetic/mentalArithmeticQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class MentalArithmeticQandSDataProvider {
  static List<int> listHasCode = List();

  static getMentalArithmeticDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<MentalArithmeticQandS> list = List();

    while (list.length < 5) {
      Expression expression = MathUtil.getMentalExp(level);
      if (expression != null) {
        MentalArithmeticQandS mentalArithmeticQandS = MentalArithmeticQandS([
          expression.firstOperand,
          "${expression.operator1}${expression.secondOperand}",
          "${expression.operator2}${expression.thirdOperand}",
          ""
        ], expression.answer);

        if (!listHasCode.contains(mentalArithmeticQandS.hashCode)) {
          listHasCode.add(mentalArithmeticQandS.hashCode);
          list.add(mentalArithmeticQandS);
          print(mentalArithmeticQandS);
        }
      }
    }
    return list;
  }
}

void main() {
  for (int i = 1; i < 10; i++) {
    print("**********$i***********");
    MentalArithmeticQandSDataProvider.getMentalArithmeticDataList(i);
  }
}
