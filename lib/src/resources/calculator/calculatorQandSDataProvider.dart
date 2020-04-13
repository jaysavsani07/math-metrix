import 'package:mathgame/src/models/calculator/calculatorQandS.dart';

class CalculatorQandSDataProvider {
  static getCalculatorDataList() {
    List<CalculatorQandS> list = List();

    list.add(CalculatorQandS(1, "5+4", 9));
    list.add(CalculatorQandS(2, "5-4", 1));
    list.add(CalculatorQandS(3, "5*4", 20));
    list.add(CalculatorQandS(4, "4/4", 1));
    list.add(CalculatorQandS(5, "8+4", 12));
    list.add(CalculatorQandS(5, "7-6", 1));
    list.add(CalculatorQandS(5, "11+4", 15));
    list.add(CalculatorQandS(5, "27+5", 32));
    list.add(CalculatorQandS(5, "19-17", 2));
    list.add(CalculatorQandS(5, "7*9", 63));
    list.add(CalculatorQandS(5, "55/5", 11));
    list.add(CalculatorQandS(5, "42-7", 35));
    list.add(CalculatorQandS(5, "26+6", 32));
    list.add(CalculatorQandS(5, "72-8", 64));
    list.add(CalculatorQandS(5, "54-23", 31));

    return list;
  }
}
