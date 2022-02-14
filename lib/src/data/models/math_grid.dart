class MathGrid {
  List<MathGridCellModel> listForSquare;
  List<int> listOfAnswer;
  late int currentAnswer;

  MathGrid({
    required this.listForSquare,
    required this.listOfAnswer,
  }) {
    currentAnswer = listOfAnswer[0];
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MathGrid &&
          runtimeType == other.runtimeType &&
          listForSquare == other.listForSquare &&
          listOfAnswer == other.listOfAnswer &&
          currentAnswer == other.currentAnswer;

  @override
  int get hashCode =>
      listForSquare.hashCode ^ listOfAnswer.hashCode ^ currentAnswer.hashCode;

  @override
  String toString() {
    return 'MathGrid{listOfAnswer: $listOfAnswer, currentAnswer: $currentAnswer}';
  }
}

class MathGridCellModel {
  int index;
  int value;
  bool isActive;
  bool isRemoved;

  MathGridCellModel(this.index, this.value, this.isActive, this.isRemoved);
}
