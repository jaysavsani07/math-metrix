class NumberPyramid {
  int id;
  List<NumPyramidCellModel> list;
  int remainingCell;

  NumberPyramid(this.id, this.list, this.remainingCell);
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
}
