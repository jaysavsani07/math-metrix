import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';

class MathPairsQandSDataProvider {
  static getMathPairsDataList() {
    List<MathPairsQandS> list = List();

    list.add(MathPairsQandS(
        1,
        [
          MathPair(1, "2", false, true),
          MathPair(2, "98", false, true),
          MathPair(3, "24/3", false, true),
          MathPair(4, "36+11", false, true),
          MathPair(5, "97+96", false, true),
          MathPair(6, "117", false, true),
          MathPair(5, "193", false, true),
          MathPair(6, "9*13", false, true),
          MathPair(4, "47", false, true),
          MathPair(3, "8", false, true),
          MathPair(2, "98", false, true),
          MathPair(1, "1*2", false, true)
        ],
        12));
    list.add(MathPairsQandS(
        2,
        [
          MathPair(1, "2", false, true),
          MathPair(2, "98", false, true),
          MathPair(3, "24/3", false, true),
          MathPair(4, "36+11", false, true),
          MathPair(5, "97+96", false, true),
          MathPair(6, "117", false, true),
          MathPair(5, "193", false, true),
          MathPair(6, "9*13", false, true),
          MathPair(4, "47", false, true),
          MathPair(3, "8", false, true),
          MathPair(2, "98", false, true),
          MathPair(1, "1*2", false, true)
        ],
        12));
    return list;
  }
}
