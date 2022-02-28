import 'dart:math';

class MathGrid {
  List<MathGridCellModel> listForSquare;
  late int currentAnswer;

  MathGrid({
    required this.listForSquare,
  }) {
    currentAnswer = getNewAnswer();
  }

  int getNewAnswer() {
    List<MathGridCellModel> list = listForSquare
        .where((element) => !element.isRemoved)
        .toList()
      ..shuffle();
    int noOfDigit = 3 + Random().nextInt(4);
    if (noOfDigit > list.length) {
      return list.map((e) {
        return e.value;
      }).fold(0, (previousValue, element) => previousValue + element);
    } else {
      return list.take(noOfDigit).map((e) {
        return e.value;
      }).fold(0, (previousValue, element) => previousValue + element);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MathGrid &&
          runtimeType == other.runtimeType &&
          listForSquare == other.listForSquare &&
          currentAnswer == other.currentAnswer;

  @override
  int get hashCode => currentAnswer.hashCode;

  @override
  String toString() {
    return 'MathGrid{listOfAnswer: currentAnswer: $currentAnswer}';
  }
}

class MathGridCellModel {
  int index;
  int value;
  bool isActive;
  bool isRemoved;

  MathGridCellModel(this.index, this.value, this.isActive, this.isRemoved);
}
