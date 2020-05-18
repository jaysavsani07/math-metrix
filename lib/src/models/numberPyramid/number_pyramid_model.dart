class NumberPyramidModel {
  int id;
  List<NumPyramidCellModel> list;
  int remainingCell;

  NumberPyramidModel(this.id, this.list, this.remainingCell);

}

class NumPyramidCellModel {
  int id;
  String text;
  int numberOnCell;
  bool isActive;
  bool isCorrect;
  bool isHidden;
  bool isHint;
  bool isDone;

  NumPyramidCellModel(this.id, this.text, this.numberOnCell, this.isActive,
      this.isCorrect, this.isHidden, this.isHint, this.isDone);

 /* @override
  String toString() {
    return 'MathPairs{text: $text, uid: $uid}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MathPair &&
              runtimeType == other.runtimeType &&
              text == other.text;

  @override
  int get hashCode => text.hashCode;*/
}
