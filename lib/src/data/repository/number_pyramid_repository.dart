import 'dart:math';

import 'package:mathgame/src/data/models/number_pyramid.dart';
import 'package:mathgame/src/utility/math_util.dart';
import 'package:tuple/tuple.dart';

class NumberPyramidRepository {
  static List<NumPyramidCellModel> singlePyramidList = <NumPyramidCellModel>[];
  static late int counter;
  static List<List<int>> hintLists = [
    [0, 6, 9, 10, 17, 20, 26],
    [1, 5, 10, 13, 19, 21, 22, 25],
    [3, 4, 8, 12, 16, 18, 24, 26],
    [2, 4, 5, 14, 16, 22, 24, 27],
    [3, 5, 8, 15, 19, 25, 27],
    [1, 4, 9, 12, 14, 16, 25],
    [0, 9, 11, 16, 19, 24, 25],
    [2, 4, 5, 14, 16, 22, 24, 27],
    [1, 3, 5, 11, 13, 15, 21, 23],
    [3, 4, 11, 13, 21, 22, 23, 27],
    [2, 3, 13, 16, 18, 20, 21],
    [0, 1, 9, 13, 16, 17, 20],
    [3, 11, 14, 19, 20, 22, 26],
    [0, 12, 13, 21, 22, 26, 27],
    [4, 8, 9, 19, 21, 24, 27],
    [1, 2, 4, 5, 7, 9, 12],
    [0, 1, 2, 4, 5, 6, 10],
    [0, 12, 13, 18, 22, 26, 27],
    [6, 12, 13, 18, 22, 26, 27],
    [0, 7, 17, 21, 24, 25, 27],
    [0, 7, 13, 18, 22, 25, 27],
    [6, 12, 17, 21, 24, 26, 27],
    [0, 12, 13, 21, 22, 25, 27],
    [0, 1, 2, 3, 4, 5, 6],
    [0, 7, 8, 9, 10, 11, 12],
    [6, 7, 12, 14, 15, 16, 17],
    [18, 19, 20, 21, 17, 7, 6],
    [2, 3, 7, 8, 11, 12, 14],
  ];

  static getPyramidDataList(int level) {
    List<NumberPyramid> pyramidsList = <NumberPyramid>[];

    for (int i = 0; i < 20; i++) {
      var singlePyramidResult = generateSinglePyramidValues();
      pyramidsList.add(NumberPyramid(
          i, singlePyramidResult.item1, singlePyramidResult.item2 + 1));
    }

    return pyramidsList;
  }

  static Tuple2<List<NumPyramidCellModel>, int> generateSinglePyramidValues() {
    singlePyramidList = <NumPyramidCellModel>[];
    counter = 1;
    int min = 1;
    int max = 8;

    List<NumPyramidCellModel> baseLineList = generateBaseLineOfPyramid(
        min, max); // generating bottom line of pyramid
    singlePyramidList.addAll(baseLineList);
    generateUpperLineOfPyramid(baseLineList,
        counter); // generating upper line of pyramid by looping one by one

    final _random = new Random();
    var selectedHintList = hintLists[_random.nextInt(hintLists.length)];

    for (int i = 0; i < selectedHintList.length; i++) {
      singlePyramidList[selectedHintList[i]].isHidden = false;
      singlePyramidList[selectedHintList[i]].isHint = true;
    }

    return new Tuple2(singlePyramidList, (27 - selectedHintList.length));
  }

  static generateUpperLineOfPyramid(
      List<NumPyramidCellModel> baseLineCellList, int counter) {
    makeSumForPyramid(baseLineCellList, 6, counter);
  }

  static makeSumForPyramid(
      List<NumPyramidCellModel> list, int loopTime, int counter) {
    if (loopTime == 0) {
      return;
    }
    List<NumPyramidCellModel> tempList = <NumPyramidCellModel>[];
    for (int k = 0; k < list.length - 1; k++) {
      int sum = list[k].numberOnCell + list[k + 1].numberOnCell;
      singlePyramidList.add(NumPyramidCellModel(
          counter, "", sum, false, false, true, false, false));
      tempList.add(NumPyramidCellModel(
          counter, "", sum, false, false, true, false, false));
      counter++;
    }
    loopTime--;
    makeSumForPyramid(tempList, loopTime, counter);
  }

  static List<NumPyramidCellModel> generateBaseLineOfPyramid(int min, int max) {
    List<NumPyramidCellModel> cellList = <NumPyramidCellModel>[];
    cellList.clear();
    for (int i = 0; i < 7; i++) {
      int randomNum = MathUtil.generateRandomAnswer(min, max);
      cellList.add(NumPyramidCellModel(
          counter, "", randomNum, false, false, true, false, false));
      counter++;
    }
    return cellList;
  }
}
