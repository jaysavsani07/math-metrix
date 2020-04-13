import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';

class MagicTriangleDataProvider {
  static getTriangleDataProviderList() {
    List<MagicTriangleModel> list = List();

    list.add(MagicTriangleModel(
        1,
        [
          MagicTriangleGrid("1", true),
          MagicTriangleGrid("2", true),
          MagicTriangleGrid("3", true),
          MagicTriangleGrid("4", true),
          MagicTriangleGrid("5", true),
          MagicTriangleGrid("6", true),
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
