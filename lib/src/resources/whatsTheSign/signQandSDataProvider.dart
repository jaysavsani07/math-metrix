import 'package:mathgame/src/models/whatsTheSign/SignQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class SignQandSDataProvider {
  static List<int> listHasCode = List();

  static getSignDataList(int level) {
    List<SignQandS> list = List();

    if (level == 1) {
      listHasCode.clear();
    }
    while (list.length < 5) {
      MathUtil.generate(level, 5 - list.length)
          .forEach((Expression expression) {
        SignQandS signQandS;
        if (expression.operator2 == null) {
          signQandS = SignQandS(expression.firstOperand, expression.operator1,
              expression.secondOperand, expression.answer.toString());
        } else {
          signQandS = SignQandS(
              list.length % 2 == 0
                  ? ("${expression.firstOperand} ${expression.operator1} ${expression.secondOperand}")
                  : (expression.firstOperand),
              list.length % 2 == 0
                  ? expression.operator2
                  : expression.operator1,
              list.length % 2 == 0
                  ? expression.thirdOperand
                  : ("${expression.secondOperand} ${expression.operator2} ${expression.thirdOperand}"),
              expression.answer.toString());
        }
        if (!listHasCode.contains(signQandS.hashCode)) {
          listHasCode.add(signQandS.hashCode);
          list.add(signQandS);
        }
      });
    }

    list.forEach((SignQandS q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  for (int i = 1; i <= 5; i++) {
    SignQandSDataProvider.getSignDataList(i);
    print("**************");
  }
}
