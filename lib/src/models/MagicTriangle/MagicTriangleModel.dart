class MagicTriangleModel {
  int id;
  List<MagicTriangleDigits> listDigits;
  List<MagicTriangleInput> listInput;
  int availableDigit;

  MagicTriangleModel(
      this.id, this.listDigits, this.listInput, this.availableDigit);
}

class MagicTriangleDigits {
  String value;
  bool isVisible;

  MagicTriangleDigits(this.value, this.isVisible);
}

class MagicTriangleInput {
  bool isActive;
  String value;

  MagicTriangleInput(this.isActive, this.value);
}
