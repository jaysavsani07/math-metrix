import 'package:mathgame/src/models/numberPyramid/number_pyramid_model.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class NumberPyramidDataProvider {
  static List<NumPyramidCellModel> singlePyramidList = new List();
  static int counter;

  static List<NumberPyramidModel> getPyramidDataList(int level) {
    List<NumberPyramidModel> pyramidsList = new List();

    for (int i = 0; i < 10; i++) {
      pyramidsList
          .add(NumberPyramidModel(i, generateSinglePyramidValues(), 28));
    }

    return pyramidsList;
  }

  static List<NumPyramidCellModel> generateSinglePyramidValues() {
    singlePyramidList = new List();
    counter = 1;
    int min = 1;
    int max = 8;
    List<NumPyramidCellModel> baseLineList = generateBaseLineOfPyramid(
        min, max); // generating bottom line of pyramid
    singlePyramidList.addAll(baseLineList);
    generateUpperLineOfPyramid(baseLineList,
        counter); // generating upper line of pyramid by looping one by one

    var list = new List<int>.generate(27, (int index) => index); // select 8 random number for hint
    list.shuffle();
    var finalList = list.sublist(0, 10);

    for (int i = 0; i < finalList.length; i++) {
      singlePyramidList[finalList[i]].isHidden = false;
      singlePyramidList[finalList[i]].isHint = true;
    }
    return singlePyramidList;
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
    List<NumPyramidCellModel> tempList = new List();
    for (int k = 0; k < list.length - 1; k++) {
      int sum = list[k].numberOnCell + list[k + 1].numberOnCell;
      singlePyramidList
          .add(NumPyramidCellModel(counter, "", sum, false, false, true, false, false));
      tempList.add(NumPyramidCellModel(counter, "", sum, false, false, true, false, false));
      counter++;
    }
    loopTime--;
    makeSumForPyramid(tempList, loopTime, counter);
  }

  static List<NumPyramidCellModel> generateBaseLineOfPyramid(int min, int max) {
    List<NumPyramidCellModel> cellList = new List();
    cellList.clear();
    for (int i = 0; i < 7; i++) {
      int randomNum = MathUtil.generateRandomAnswer(min, max);
      cellList
          .add(NumPyramidCellModel(counter, "", randomNum, false, false, true, false, false));
      counter++;
    }
    return cellList;
  }
}

