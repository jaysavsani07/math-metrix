class MagicTriangleModel {
  int id;
  List<MagicTriangleGrid> listGrid;
  List<MagicTriangleInput> listTriangle;
  int availableDigit;
  int answer;

  MagicTriangleModel(
      this.id, this.listGrid, this.listTriangle, this.availableDigit, this.answer);
}

class MagicTriangleGrid {
  String value;
  bool isVisible;

  MagicTriangleGrid(this.value, this.isVisible);
}

class MagicTriangleInput {
  bool isActive;
  String value;

  MagicTriangleInput(this.isActive, this.value);
}
