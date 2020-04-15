import 'package:mathgame/src/models/MathGrid/MathGridModel.dart';
import 'dart:math';

class MathGridDataProvider {
  static List<int> listOf9 = List<int>.generate(9, (i) => 9);
  static List<int> listOf8 = List<int>.generate(9, (i) => 8);
  static List<int> listOf7 = List<int>.generate(9, (i) => 7);
  static List<int> listOf6 = List<int>.generate(9, (i) => 6);
  static List<int> listOf5 = List<int>.generate(9, (i) => 5);
  static List<int> listOf4 = List<int>.generate(9, (i) => 4);
  static List<int> listOf3 = List<int>.generate(9, (i) => 3);
  static List<int> listOf2 = List<int>.generate(9, (i) => 2);
  static List<int> listOf1 = List<int>.generate(9, (i) => 1);

  static List<MathGridCellModel> listForSquare() {
    List<int> list = new List();
    List<MathGridCellModel> listGrid = new List();
    list = listOf9 +
        listOf8 +
        listOf7 +
        listOf6 +
        listOf5 +
        listOf4 +
        listOf3 +
        listOf2 +
        listOf1;
    list.shuffle();
    for (int i = 0; i < list.length; i++) {
      listGrid.add(MathGridCellModel(i, list[i], false, false));
    }
    return listGrid;
  }

  static int generateRandomAnswer() {
    final _random = new Random();
    int min = 5;
    int max = 40;
    int result = min + _random.nextInt(max - min);
    return result;
  }

  static List<int> listOfAnswer() {
    List<int> listRandom = new List();
    for (int i = 0; i < 20; i++) {
      listRandom.add(generateRandomAnswer());
    }
    return listRandom;
  }

  static List<MathGridModel> getMathGridData() {
    List<MathGridModel> list = new List();
    list.add(MathGridModel(1, listForSquare(), listOfAnswer()));
    list.add(MathGridModel(2, listForSquare(), listOfAnswer()));
    list.add(MathGridModel(3, listForSquare(), listOfAnswer()));
    list.add(MathGridModel(4, listForSquare(), listOfAnswer()));
    list.add(MathGridModel(5, listForSquare(), listOfAnswer()));
    return list;
  }
}
