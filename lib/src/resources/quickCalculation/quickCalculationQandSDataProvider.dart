import 'package:mathgame/src/models/quickCalculation/quickCalculationQandS.dart';

class QuickCalculationQandSDataProvider {
  static getQuickCalculationDataList() {
    List<QuickCalculationQandS> list = List();

    list.add(QuickCalculationQandS(1, "5+4", 9));
    list.add(QuickCalculationQandS(2, "5-4", 1));
    list.add(QuickCalculationQandS(3, "5*4", 20));
    list.add(QuickCalculationQandS(4, "4/4", 1));
    list.add(QuickCalculationQandS(5, "8+4", 12));
    list.add(QuickCalculationQandS(5, "7-6", 1));
    list.add(QuickCalculationQandS(5, "11+4", 15));
    list.add(QuickCalculationQandS(5, "27+5", 32));
    list.add(QuickCalculationQandS(5, "19-17", 2));
    list.add(QuickCalculationQandS(5, "7*9", 63));
    list.add(QuickCalculationQandS(5, "55/5", 11));
    list.add(QuickCalculationQandS(5, "42-7", 35));
    list.add(QuickCalculationQandS(5, "26+6", 32));
    list.add(QuickCalculationQandS(5, "72-8", 64));
    list.add(QuickCalculationQandS(5, "54-23", 31));

    return list;
  }
}
