import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';

class MagicTriangleDataProvider {
  static Map correctMagicTriangle = {
    "9": [1, 2, 3, 4, 5, 6],
    "10": [1, 2, 3, 4, 5, 6],
    "11": [1, 2, 3, 4, 5, 6],
    "12": [1, 2, 3, 4, 5, 6],
    "18": [4, 5, 6, 7, 8, 9]
  };
  static int availableDigit = 6;

  static getTriangleDataProviderList() {
    List<MagicTriangleModel> list = List();

    list.add(MagicTriangleModel(
        1,
        getMagicTriangleGrid(correctMagicTriangle['9']),
        getMagicTriangleInput(),
        availableDigit,
        9));
    list.add(MagicTriangleModel(
        1,
        getMagicTriangleGrid(correctMagicTriangle['10']),
        getMagicTriangleInput(),
        availableDigit,
        10));
    list.add(MagicTriangleModel(
        1,
        getMagicTriangleGrid(correctMagicTriangle['11']),
        getMagicTriangleInput(),
        availableDigit,
        11));
    list.add(MagicTriangleModel(
        1,
        getMagicTriangleGrid(correctMagicTriangle['12']),
        getMagicTriangleInput(),
        availableDigit,
        12));
    list.add(MagicTriangleModel(
        1,
        getMagicTriangleGrid(correctMagicTriangle['18']),
        getMagicTriangleInput(),
        availableDigit,
        18));
    list.shuffle();
    return list;
  }

  static List<MagicTriangleGrid> getMagicTriangleGrid(List<int> list) {
    List<MagicTriangleGrid> gridList = List<MagicTriangleGrid>();
    for (int i = 0; i < 6; i++) {
      print(list[i].toString());
      gridList.add(MagicTriangleGrid(list[i].toString(), true));
    }
    gridList.shuffle();
    return gridList;
  }

  static List<MagicTriangleInput> getMagicTriangleInput() {
    List<MagicTriangleInput> inputList = List<MagicTriangleInput>();
    for (int i = 0; i < 6; i++) {
      inputList.add(MagicTriangleInput(false, ""));
    }
    inputList[0].isActive = false;
    return inputList;
  }
}
