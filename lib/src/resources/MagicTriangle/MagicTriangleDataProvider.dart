import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';

class MagicTriangleDataProvider {
  static getTriangleDataProviderList() {
    List<MagicTriangleModel> list = List();

    list.add(MagicTriangleModel(
        1,
        [
          MagicTriangleDigits("1", true),
          MagicTriangleDigits("2", true),
          MagicTriangleDigits("3", true),
          MagicTriangleDigits("4", true),
          MagicTriangleDigits("5", true),
          MagicTriangleDigits("6", true),
        ],
        [
          MagicTriangleInput(true, ""),
          MagicTriangleInput(false, ""),
          MagicTriangleInput(false, ""),
          MagicTriangleInput(false, ""),
          MagicTriangleInput(false, ""),
          MagicTriangleInput(false, "")
        ],
        6));
    return list;
  }
}
