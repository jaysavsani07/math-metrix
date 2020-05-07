import 'package:mathgame/src/models/whatsTheSign/SignQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class SignQandSDataProvider {
  static getSignDataList(int level) {
    List<SignQandS> list = List();

    List<Expression> expressionList = MathUtil.generate(level, 5);
    expressionList.forEach((Expression expression) {
      list.add(SignQandS(1, expression.firstOperand, expression.operator,
          expression.secondOperand, expression.answer.toString()));
    });

    list.forEach((SignQandS q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  SignQandSDataProvider.getSignDataList(1);
}
