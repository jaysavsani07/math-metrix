import 'package:mathgame/src/models/calculator/calculatorQandS.dart';

class CalculatorQandSDataProvider {
  static getCalculatorDataList() {
    List<CalculatorQandS> list = List();

    list.add(CalculatorQandS(1, "5+4", 9));
    list.add(CalculatorQandS(2, "5-4", 1));
    list.add(CalculatorQandS(3, "5*4", 20));
    list.add(CalculatorQandS(4, "4/4", 1));
    list.add(CalculatorQandS(5, "4+4", 8));

    return list;
  }
}
