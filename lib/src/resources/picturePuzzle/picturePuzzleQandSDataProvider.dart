import 'package:mathgame/src/models/picturePuzzle/PicturePuzzleRootQandS.dart';
import 'package:mathgame/src/utility/mathUtil.dart';

class PicturePuzzleQandSDataProvider {
  static List<int> listHasCode = List();

  static getPicturePuzzleDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }
    List<PicturePuzzleQandS> list = List();
    while (list.length < 5) {
      List<PicturePuzzle> puzzleList = List();

      List<List<String>> matrix = generateMatrix(level, list.length);
      while (matrix[0][5] == matrix[1][5]) {
        matrix = generateMatrix(level, list.length);
      }

      List<PicturePuzzleData> picturePuzzleDataList =
          getPicturePuzzleData(matrix);
      picturePuzzleDataList
          .asMap()
          .forEach((int i, PicturePuzzleData picturePuzzleData) {
        puzzleList.add(PicturePuzzle([
          PicturePuzzleShape(
              isSign: false,
              picturePuzzleShapeType: picturePuzzleData.picturePuzzleShapeType1,
              text: ""),
          PicturePuzzleShape(isSign: true, text: picturePuzzleData.sign1),
          PicturePuzzleShape(
              isSign: false,
              picturePuzzleShapeType: picturePuzzleData.picturePuzzleShapeType2,
              text: ""),
          PicturePuzzleShape(isSign: true, text: picturePuzzleData.sign2),
          PicturePuzzleShape(
              isSign: false,
              picturePuzzleShapeType: picturePuzzleData.picturePuzzleShapeType3,
              text: ""),
          PicturePuzzleShape(isSign: true, text: "="),
          PicturePuzzleShape(
              isSign: true,
              text: i == picturePuzzleDataList.length - 1
                  ? "?"
                  : picturePuzzleData.text)
        ]));
      });

      list.add(PicturePuzzleQandS(
          puzzleList, int.parse(picturePuzzleDataList.last.text)));
    }
    return list;
  }

  static List<PicturePuzzleData> getPicturePuzzleData(
      List<List<String>> matrix) {
    List<PicturePuzzleData> picturePuzzleData = List();

    Map<String, PicturePuzzleShapeType> map = Map();

    matrix.forEach((list) {
      list
          .where((subList) => !MathUtil.isOperator(subList))
          .toList()
          .asMap()
          .forEach((i, subList) {
        if (i != list.length - 3 && !map.containsKey(subList)) {
          map[subList] = map.length == 0
              ? PicturePuzzleShapeType.CIRCLE
              : (map.length == 1
                  ? PicturePuzzleShapeType.TRIANGLE
                  : PicturePuzzleShapeType.SQUARE);
        }
      });
    });

    print(map);
    matrix.forEach((list) {
      picturePuzzleData.add(PicturePuzzleData(
          map[list[0]], list[1], map[list[2]], list[3], map[list[4]], list[5]));
    });

    picturePuzzleData.forEach((list) {
      print(list);
    });

    return picturePuzzleData;
  }

  static List<List<String>> generateMatrix(int level, int index) {
    if (level == 1) {
      switch (index) {
        case 0:
        case 1:
          List<String> listDigit = MathUtil.generateRandomNumber(1, 10, 3);
          List<String> listSign = MathUtil.generateRandomSign1(2);

          var tempList = [
            listDigit[0],
            listDigit[1],
            listDigit[0],
            listDigit[1],
            listDigit[0],
            listDigit[1],
          ]..shuffle();

          var tempList1 = [
            listDigit[1],
            listDigit[2],
            listDigit[1],
            listDigit[2],
            listDigit[1],
            listDigit[2]
          ]..shuffle();

          return [
            [
              tempList[0],
              "+",
              tempList[1],
              "+",
              tempList[2],
              "${int.parse(tempList[0]) + int.parse(tempList[1]) + int.parse(tempList[2])}"
            ],
            [
              tempList1[3],
              "+",
              tempList1[4],
              "+",
              tempList1[5],
              "${int.parse(tempList1[3]) + int.parse(tempList1[4]) + int.parse(tempList1[5])}"
            ],
            [
              listDigit[2],
              "+",
              listDigit[2],
              "+",
              listDigit[2],
              "${int.parse(listDigit[2]) * 3}"
            ]
          ]
            ..shuffle()
            ..add([
              listDigit[0],
              "+",
              listDigit[1],
              "+",
              listDigit[2],
              "${int.parse(listDigit[0]) + int.parse(listDigit[1]) + int.parse(listDigit[2])}"
            ]);
          break;
        case 2:
        case 3:
        case 4:
          List<String> listDigit = MathUtil.generateRandomNumber(1, 10, 3);
          List<String> listSign = ["+", "-", "*"]
            ..shuffle()
            ..removeAt(1);

          var tempList = [
            listDigit[0],
            listDigit[1],
            listDigit[2],
            listDigit[0],
            listDigit[1],
            listDigit[2]
          ]..shuffle();

          return [
            [
              tempList[0],
              listSign[0],
              tempList[1],
              "+",
              tempList[2],
              "${MathUtil.evaluate(int.parse(tempList[0]), listSign[0], int.parse(tempList[1])) + int.parse(tempList[2])}"
            ],
            [
              tempList[3],
              listSign[1],
              tempList[4],
              "-",
              tempList[5],
              "${MathUtil.evaluate(int.parse(tempList[3]), listSign[1], int.parse(tempList[4])) - int.parse(tempList[5])}"
            ],
            [
              listDigit[2],
              "+",
              listDigit[2],
              "+",
              listDigit[2],
              "${int.parse(listDigit[2]) * 3}"
            ]
          ]..add([
              listDigit[0],
              "+",
              listDigit[1],
              "+",
              listDigit[2],
              "${int.parse(listDigit[0]) + int.parse(listDigit[1]) + int.parse(listDigit[2])}"
            ]);
          break;
      }
    } else {
      List<String> listDigit = List();
      while (listDigit.length < 3) {
        MathUtil.generateRandomNumber(level, 10 + level, 3).forEach((digit) {
          if (!listDigit.contains(digit)) {
            listDigit.add(digit);
          }
        });
      }
      List<String> listSign = ["+", "-", "*"]..shuffle();

      var tempList = [
        listDigit[0],
        listDigit[1],
        listDigit[2],
        listDigit[0],
        listDigit[1],
        listDigit[2]
      ]..shuffle();

      return [
        [
          tempList[0],
          listSign[0],
          tempList[1],
          "+",
          tempList[2],
          "${MathUtil.evaluate(int.parse(tempList[0]), listSign[0], int.parse(tempList[1])) + int.parse(tempList[2])}"
        ],
        [
          tempList[3],
          listSign[1],
          tempList[4],
          "-",
          tempList[5],
          "${MathUtil.evaluate(int.parse(tempList[3]), listSign[1], int.parse(tempList[4])) - int.parse(tempList[5])}"
        ],
        [
          listDigit[2],
          listSign[0],
          listDigit[2],
          listSign[1],
          listDigit[2],
          "${(MathUtil.getPrecedence(listSign[0]) >= MathUtil.getPrecedence(listSign[1])) ? (MathUtil.evaluate(MathUtil.evaluate(int.parse(listDigit[2]), listSign[0], int.parse(listDigit[2])), listSign[1], int.parse(listDigit[2]))) : (MathUtil.evaluate(int.parse(listDigit[2]), listSign[0], MathUtil.evaluate(int.parse(listDigit[2]), listSign[1], int.parse(listDigit[2]))))}"
        ]
      ]..add([
          listDigit[0],
          listSign[0],
          listDigit[1],
          listSign[2],
          listDigit[2],
          "${(MathUtil.getPrecedence(listSign[0]) >= MathUtil.getPrecedence(listSign[2])) ? (MathUtil.evaluate(MathUtil.evaluate(int.parse(listDigit[0]), listSign[0], int.parse(listDigit[1])), listSign[2], int.parse(listDigit[2]))) : (MathUtil.evaluate(int.parse(listDigit[0]), listSign[0], MathUtil.evaluate(int.parse(listDigit[1]), listSign[2], int.parse(listDigit[2]))))}"
        ]);
    }
  }
}

void main() {
  for (int j = 1; j < 5; j++) {
    for (int i = 0; i < 2; i++) {
      List<List<String>> matrix =
          PicturePuzzleQandSDataProvider.generateMatrix(j, i);
      while (matrix[0][5] == matrix[1][5] ||
          matrix[0][5] == matrix[2][5] ||
          matrix[1][5] == matrix[2][5]) {
        matrix = PicturePuzzleQandSDataProvider.generateMatrix(j, 1);
      }

      print(matrix);
    }
  }
//  print(PicturePuzzleQandSDataProvider.getPicturePuzzleDataList(1));
}
