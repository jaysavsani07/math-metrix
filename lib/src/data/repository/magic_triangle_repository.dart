import 'package:mathgame/src/data/models/magic_triangle.dart';

class MagicTriangleRepository {
  static Map correctMagicTriangle = {
    "9": [1, 2, 3, 4, 5, 6],
    "10": [1, 2, 3, 4, 5, 6],
    "11": [1, 2, 3, 4, 5, 6],
    "12": [1, 2, 3, 4, 5, 6],
    "18": [4, 5, 6, 7, 8, 9],
    "17": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "19": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "20": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "21": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "23": [1, 2, 3, 4, 5, 6, 7, 8, 9],
    "126": [1, 4, 9, 16, 25, 36, 49, 64, 81],
  };

  static getTriangleDataProviderList() {
    List<MagicTriangle> list = <MagicTriangle>[];

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['9']),
        listTriangle: getMagicTriangleInput(6),
        answer: 9,
      ),
    );

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['10']),
        listTriangle: getMagicTriangleInput(6),
        answer: 10,
      ),
    );
    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['11']),
        listTriangle: getMagicTriangleInput(6),
        answer: 11,
      ),
    );
    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['12']),
        listTriangle: getMagicTriangleInput(6),
        answer: 12,
      ),
    );
    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['18']),
        listTriangle: getMagicTriangleInput(6),
        answer: 18,
      ),
    );
    list.shuffle();
    return list;
  }

  static getNextLevelTriangleDataProviderList() {
    List<MagicTriangle> list = <MagicTriangle>[];

    list.add(
      MagicTriangle(
        listGrid: getMagicTriangleGrid(correctMagicTriangle['20']),
        listTriangle: getMagicTriangleInput(9),
        answer: 20,
      ),
    );

    list.shuffle();
    return list;
  }

  static List<MagicTriangleGrid> getMagicTriangleGrid(List<int> list) {
    List<MagicTriangleGrid> gridList = <MagicTriangleGrid>[];
    for (int i = 0; i < list.length; i++) {
      gridList.add(MagicTriangleGrid(list[i].toString(), true));
    }
    gridList.shuffle();
    return gridList;
  }

  static List<MagicTriangleInput> getMagicTriangleInput(int length) {
    List<MagicTriangleInput> inputList = <MagicTriangleInput>[];
    for (int i = 0; i < length; i++) {
      inputList.add(MagicTriangleInput(false, ""));
    }
    inputList[0].isActive = false;
    return inputList;
  }
}

/*
17 = 1 + 5 + 9 + 2 = 2 + 4+ 8+ 3 = 3 + 6 + 7 + 1
17 = 1 + 6 + 8 + 2 = 2 + 5 + 7 + 3 = 3 + 4 + 9 + 1

19 = 1 + 5 + 9 + 4 = 4 + 2 + 6 + 7 = 7 + 3 + 8 + 1
19 = 1 + 6 + 8 + 4 = 4 + 3 + 5 + 7 = 7 + 2 + 9 + 1
19 = 2 + 5 + 9 + 3 = 3 + 1 + 8 + 7 = 7 + 4 + 6 + 2
19 = 2 + 6 + 8 + 3 = 3 + 4 + 5 + 7 = 7 + 1 + 9 + 2

20 = 1 + 6 + 8 + 5 = 5 + 2 + 4 + 9 = 9 + 3 + 7 + 1
20 = 2 + 4 + 9 + 5 = 5 + 1 + 6 + 8 = 8 + 3 + 7 + 2
20 = 2 + 6 + 7 + 5 = 5 + 3 + 4 + 8 = 8 + 1 + 9 + 2
20 = 3 + 4 + 8 + 5 = 5 + 2 + 6 + 7 = 7 + 1 + 9 + 3
20 = 4 + 2 + 9 + 5 = 5 + 1 + 8 + 6 = 6 + 3 + 7 + 4
20 = 4 + 3 + 8 + 5 = 5 + 2 + 7 + 6 = 6 + 1 + 9 + 4

21 = 3 + 5 + 7 + 6 = 6 + 2 + 4 + 9 = 9 + 1 + 8 + 3
21 = 3 + 4 + 8 + 6 = 6 + 1 + 5 + 9 = 9 + 2 + 7 + 3
21 = 3 + 2 + 9 + 7 = 7 + 1 + 5 + 8 = 8 + 4 + 6 + 3
21 = 3 + 5 + 6 + 7 = 7 + 2 + 4 + 8 = 8 + 1 + 9 + 3

23 = 7 + 2 + 6 + 8 = 8 + 1 + 5 + 9 = 9 + 3 + 4 + 7
23 = 7 + 3 + 5 + 8 = 8 + 2 + 4 + 9 = 9 + 1 + 6 + 7
126 = 4 + 16 + 81 + 25 = 4 + 49 + 9 + 64 = 64 + 36 + 1 + 25
*/
