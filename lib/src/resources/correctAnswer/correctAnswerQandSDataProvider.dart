import 'package:mathgame/src/models/correctAnswer/correctAnswerQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class CorrectAnswerQandSDataProvider {
  static getCorrectAnswerDataList(int level) {
    List<CorrectAnswerQandS> list = List();

    int i = 0;
    int min = 3;
    min = min < 1 ? 1 : min;
    int max = 10;

    while (i < 5) {
      int x1 = MathUtil.generateRandomAnswer(min, max);
      String x2 = MathUtil.generateRandomSign();
      int x3 = MathUtil.generateRandomAnswer(min, max);

      if ((x2 == "/" && x1 > x3 && x1 % x3 == 0) || x2 != "/") {
        List<int> x = List();
        x.add((i % 2 == 0) ? x1 : x3);
        while (x.length < 4) {
          int x4 = MathUtil.generateRandomAnswer(
              (((i % 2 == 0) ? x1 : x3) - 5) < 0
                  ? 1
                  : ((i % 2 == 0) ? x1 : x3) - 5,
              ((i % 2 == 0) ? x1 : x3) + 5);
          if (!x.contains(x4)) x.add(x4);
        }

        x.shuffle();

        if (!list.contains(CorrectAnswerQandS(
            1,
            "${((i % 2 == 0) ? "?" : x1)} $x2 ${((i % 2 == 0) ? x3 : "?")} = ${MathUtil.evaluate(x1, x2, x3)}",
            x[0].toString(),
            x[1].toString(),
            x[2].toString(),
            x[3].toString(),
            (i % 2 == 0) ? x1 : x3))) {
          list.add(CorrectAnswerQandS(
              1,
              "${((i % 2 == 0) ? "?" : x1)} $x2 ${((i % 2 == 0) ? x3 : "?")} = ${MathUtil.evaluate(x1, x2, x3)}",
              x[0].toString(),
              x[1].toString(),
              x[2].toString(),
              x[3].toString(),
              (i % 2 == 0) ? x1 : x3));
          i++;
        }
      }
    }

    for (int i = 0; i < list.length; i++) {
      var result = list.where((result) => result.question.contains("/"));
      if (!(result.length > 0)) {
        while (i < 2) {
          int x1 = MathUtil.generateRandomAnswer(min, max);
          String x2 = "/";
          int x3 = MathUtil.generateRandomAnswer(min, max);
          if ((x1 > x3 && x1 % x3 == 0)) {
            List<int> x = List();
            x.add((i % 2 == 0) ? x1 : x3);
            while (x.length < 4) {
              int x4 = MathUtil.generateRandomAnswer(
                  (((i % 2 == 0) ? x1 : x3) - 5) < 0
                      ? 1
                      : ((i % 2 == 0) ? x1 : x3) - 5,
                  ((i % 2 == 0) ? x1 : x3) + 5);
              if (!x.contains(x4)) x.add(x4);
            }

            x.shuffle();
            if (!list.contains(CorrectAnswerQandS(
                1,
                "${((i % 2 == 0) ? "?" : x1)} $x2 ${((i % 2 == 0) ? x3 : "?")} = ${MathUtil.evaluate(x1, x2, x3)}",
                x[0].toString(),
                x[1].toString(),
                x[2].toString(),
                x[3].toString(),
                (i % 2 == 0) ? x1 : x3))) {
              list.add(CorrectAnswerQandS(
                  1,
                  "${((i % 2 == 0) ? "?" : x1)} $x2 ${((i % 2 == 0) ? x3 : "?")} = ${MathUtil.evaluate(x1, x2, x3)}",
                  x[0].toString(),
                  x[1].toString(),
                  x[2].toString(),
                  x[3].toString(),
                  (i % 2 == 0) ? x1 : x3));
              i++;
            }
          }
        }
      }
    }
    list.shuffle();
    list.forEach((CorrectAnswerQandS q){
      print("${q.question} ${q.answer}");
    });
    return list;
  }
}

void main() {
  for (int i = 0; i < 2; i++) {
    CorrectAnswerQandSDataProvider.getCorrectAnswerDataList(1);
  }
}
