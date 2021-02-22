import 'package:mathgame/src/data/models/mental_arithmetic.dart';
import 'package:mathgame/src/utility/math_util.dart';

class MentalArithmeticRepository {
  static List<int> listHasCode = List();

  static getMentalArithmeticDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<MentalArithmetic> list = List();

    while (list.length < 5) {
      Expression expression = MathUtil.getMentalExp(level);
      if (expression != null) {
        MentalArithmetic mentalArithmeticQandS = MentalArithmetic([
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
    MentalArithmeticRepository.getMentalArithmeticDataList(i);
  }
}
