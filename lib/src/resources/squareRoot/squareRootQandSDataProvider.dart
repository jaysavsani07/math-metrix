import 'package:mathgame/src/models/squareRoot/SquareRootQandS.dart';

class SquareRootQandSDataProvider {
  static getSquareDataList() {
    List<SquareRootQandS> list = List();

    list.add(SquareRootQandS(1, "36", "7", "4", "5", "6", 6));
    list.add(SquareRootQandS(2, "121", "12", "11", "13", "16", 11));
    list.add(SquareRootQandS(3, "361", "21", "14", "19", "17", 19));
    list.add(SquareRootQandS(4, "256", "16", "17", "12", "18", 16));
    list.add(SquareRootQandS(5, "81", "7", "9", "11", "14", 9));
    list.add(SquareRootQandS(6, "400", "10", "15", "20", "25", 20));
    list.add(SquareRootQandS(7, "169", "14", "16", "13", "11", 13));
    list.add(SquareRootQandS(8, "64", "7", "9", "11", "8", 84));
    list.add(SquareRootQandS(5, "25", "4", "8", "5", "6", 5));
    list.add(SquareRootQandS(10, "324", "17", "19", "18", "16", 18));
    return list;
  }
}
