import 'package:mathgame/src/models/mentalArithmetic/mentalArithmeticQandS.dart';

class MentalArithmeticQandSDataProvider {
  static getMentalArithmeticDataList() {
    List<MentalArithmeticQandS> list = List();

    list.add(MentalArithmeticQandS(1, ["5", "-1", "*5", ""], 20));
    list.add(MentalArithmeticQandS(2, ["5", "/5", "+1", ""], 2));
    list.add(MentalArithmeticQandS(3, ["11", "-6", "*2", ""], 10));
    list.add(MentalArithmeticQandS(4, ["-5", "-6", "+1", ""], -10));
    return list;
  }
}
