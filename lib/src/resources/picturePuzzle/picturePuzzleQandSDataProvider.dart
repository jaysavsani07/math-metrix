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

//      List<List<String>> matrix = generateMatrix(level, list.length);
//      while (matrix[0][5] == matrix[1][5]) {
//        matrix = generateMatrix(level, list.length);
//      }

      List<PicturePuzzleData> picturePuzzleDataList =
          generateMatrix1(level, list.length);
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

  static List<List<PicturePuzzleShapeType>> getShapeMatrix() {
    List<List<PicturePuzzleShapeType>> list = List();
    var shapeList = [
      PicturePuzzleShapeType.CIRCLE,
      PicturePuzzleShapeType.SQUARE,
      PicturePuzzleShapeType.TRIANGLE
    ]..shuffle();
    list.add([shapeList[0], shapeList[0], shapeList[0]]);
    shapeList.removeAt(0);
    while (list.length < 3) {
      if (list.length == 1)
        list.add([shapeList[0], list[0][0], shapeList[0]]..shuffle());
      else {
        list.add([shapeList[0], shapeList[1], shapeList[1]]..shuffle());
      }
    }
    list.add([list[0][0], shapeList[0], shapeList[1]]..shuffle());
    return list;
  }

  static List<PicturePuzzleData> generateMatrix1(int level, int index) {
    List<List<PicturePuzzleShapeType>> listShape = getShapeMatrix();
    List<PicturePuzzleData> picturePuzzleData = List();
    Map<PicturePuzzleShapeType, String> map = Map();

    if (level == 1) {
      switch (index) {
        case 0:
        case 1:
          List<String> listDigit = MathUtil.generateRandomNumber(1, 10, 3);

          listShape.forEach((list) {
            list.asMap().forEach((i, subList) {
              if (!map.containsKey(subList)) {
                map[subList] = map.length == 0
                    ? listDigit[0]
                    : (map.length == 1 ? listDigit[1] : listDigit[2]);
              }
            });
          });
          listShape.forEach((list) {
            picturePuzzleData.add(PicturePuzzleData(
                list[0],
                "+",
                list[1],
                "+",
                list[2],
                getResult(map[list[0]], "+", map[list[1]], "+", map[list[2]])));
          });

          break;
        case 2:
        case 3:
        case 4:
          List<String> listDigit = MathUtil.generateRandomNumber(1, 10, 3);
          List<String> listSign = ["+", "-", "*"]
            ..shuffle()
            ..removeAt(1);

          listShape.forEach((list) {
            list.asMap().forEach((i, subList) {
              if (!map.containsKey(subList)) {
                map[subList] = map.length == 0
                    ? listDigit[0]
                    : (map.length == 1 ? listDigit[1] : listDigit[2]);
              }
            });
          });
          listShape.forEach((list) {
            if (list[0] == list[1] &&
                list[1] == list[2] &&
                list[0] == list[1]) {
              picturePuzzleData.add(PicturePuzzleData(
                  list[0],
                  "+",
                  list[1],
                  "+",
                  list[2],
                  getResult(
                      map[list[0]], "+", map[list[1]], "+", map[list[2]])));
            } else if (list[0] != list[1] &&
                list[1] != list[2] &&
                list[0] != list[1]) {
              picturePuzzleData.add(PicturePuzzleData(
                  list[0],
                  "+",
                  list[1],
                  "+",
                  list[2],
                  getResult(
                      map[list[0]], "+", map[list[1]], "+", map[list[2]])));
            } else if (listSign.length == 2) {
              picturePuzzleData.add(PicturePuzzleData(
                  list[0],
                  listSign[0],
                  list[1],
                  "+",
                  list[2],
                  getResult(map[list[0]], listSign[0], map[list[1]], "+",
                      map[list[2]])));
              listSign.removeAt(0);
            } else {
              picturePuzzleData.add(PicturePuzzleData(
                  list[0],
                  listSign[0],
                  list[1],
                  "-",
                  list[2],
                  getResult(map[list[0]], listSign[0], map[list[1]], "-",
                      map[list[2]])));
            }
          });
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

      listShape.forEach((list) {
        list.asMap().forEach((i, subList) {
          if (!map.containsKey(subList)) {
            map[subList] = map.length == 0
                ? listDigit[0]
                : (map.length == 1 ? listDigit[1] : listDigit[2]);
          }
        });
      });

      listShape.forEach((list) {
        if (list[0] == list[1] && list[1] == list[2] && list[0] == list[1]) {
          picturePuzzleData.add(PicturePuzzleData(
              list[0],
              listSign[0],
              list[1],
              listSign[2],
              list[2],
              getResult(map[list[0]], listSign[0], map[list[1]], listSign[2],
                  map[list[2]])));
        } else if (list[0] != list[1] &&
            list[1] != list[2] &&
            list[0] != list[1]) {
          picturePuzzleData.add(PicturePuzzleData(
              list[0],
              listSign[0] == "-" ? "+" : listSign[0],
              list[1],
              listSign[1] == "-" ? "+" : listSign[1],
              list[2],
              getResult(
                  map[list[0]],
                  listSign[0] == "-" ? "+" : listSign[0],
                  map[list[1]],
                  listSign[1] == "-" ? "+" : listSign[1],
                  map[list[2]])));
        } else if (listSign.length == 3) {
          picturePuzzleData.add(PicturePuzzleData(
              list[0],
              listSign[0],
              list[1],
              "+",
              list[2],
              getResult(
                  map[list[0]], listSign[0], map[list[1]], "+", map[list[2]])));
          listSign.removeAt(0);
        } else {
          picturePuzzleData.add(PicturePuzzleData(
              list[0],
              listSign[0],
              list[1],
              "-",
              list[2],
              getResult(
                  map[list[0]], listSign[0], map[list[1]], "-", map[list[2]])));
        }
      });
    }

    return picturePuzzleData;
  }

  static String getResult(
      String op1, String sign1, String op2, String sign2, String op3) {
    return "${(MathUtil.getPrecedence(sign1) >= MathUtil.getPrecedence(sign2)) ? (MathUtil.evaluate(MathUtil.evaluate(int.parse(op1), sign1, int.parse(op2)), sign2, int.parse(op3))) : (MathUtil.evaluate(int.parse(op1), sign1, MathUtil.evaluate(int.parse(op2), sign2, int.parse(op3))))}";
  }

  static List<List<String>> generateMatrix(int level, int index) {
    List<List<PicturePuzzleShapeType>> listShape = getShapeMatrix();
    if (level == 1) {
      switch (index) {
        case 0:
        case 1:
          List<String> listDigit = MathUtil.generateRandomNumber(1, 10, 3);

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
  for(int k=1;k<10;k++)
  for (int j = 1; j < 3; j++) {
    for (int i = 0; i < 5; i++) {
      var matrix = PicturePuzzleQandSDataProvider.generateMatrix1(j, i);
      print(matrix);
    }
  }
//  print(PicturePuzzleQandSDataProvider.getShapeMatrix());
}
