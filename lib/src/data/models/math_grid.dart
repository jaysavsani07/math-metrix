class MathGrid {
  int id;
  List<MathGridCellModel> listForSquare;
  List<int> listOfAnswer;
  int currentAnswer;

  MathGrid(this.id, this.listForSquare, this.listOfAnswer) {
    currentAnswer = listOfAnswer[0];
  }
}

class MathGridCellModel {
  int index;
  int value;
  bool isActive;
  bool isRemoved;

  MathGridCellModel(this.index, this.value, this.isActive, this.isRemoved);
}
