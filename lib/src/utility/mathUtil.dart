import 'dart:math';

class MathUtil {
  static int generateRandomAnswer(int min, int max) {
    final _random = new Random();
    int result = min + _random.nextInt(max - min);
    return result;
  }

  static String generateRandomSign() {
    var x = ['/', '*', '-', '+'];
    final _random = new Random();
    int result = _random.nextInt(3);
    return x[result];
  }

  static int evaluate(int x1, String sign, int x3) {
    switch (sign) {
      case "+":
        return x1 + x3;
      case "-":
        return x1 - x3;
      case "*":
        return x1 * x3;
      case "/":
        return x1 ~/ x3;
    }
  }
}

void main() {
  for(int i=0;i<100;i++){
    print("${MathUtil.generateRandomAnswer(10, 30)} ${MathUtil.generateRandomAnswer(10, 30)}");
  }
}
