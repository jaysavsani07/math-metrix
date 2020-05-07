import 'package:mathgame/src/models/correctAnswer/correctAnswerQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class CorrectAnswerQandSDataProvider {
  static getCorrectAnswerDataList(int level) {
    List<CorrectAnswerQandS> list = List();

    List<Expression> expressionList = MathUtil.generate(level, 5);
    int i = 0;
    expressionList.forEach((Expression expression) {
      List<int> x = List();
      int val = (i % 2 == 0)
          ? int.parse(expression.firstOperand)
          : int.parse(expression.secondOperand);
      x.add(val);

      while (x.length < 4) {
        int x4 = int.parse(MathUtil.generateRandomNumber(
                (val - 5) < 0 ? 1 : val - 5, val + 5, 1)
            .first);
        if (!x.contains(x4)) x.add(x4);
      }

      x.shuffle();
      list.add(CorrectAnswerQandS(
          1,
          "${((i % 2 == 0) ? "?" : expression.firstOperand)} ${expression.operator} ${((i % 2 == 0) ? expression.secondOperand : "?")} = ${expression.answer}",
          x[0].toString(),
          x[1].toString(),
          x[2].toString(),
          x[3].toString(),
          (i % 2 == 0)
              ? int.parse(expression.firstOperand)
              : int.parse(expression.secondOperand)));
      i++;
    });

    list.forEach((CorrectAnswerQandS q) {
      print("${q.toString()}");
    });
    return list;
  }
}

void main() {
  for (int i = 0; i < 2; i++) {
    CorrectAnswerQandSDataProvider.getCorrectAnswerDataList(1);
  }
}
