enum PicturePuzzleQuestionItemType {
  shape,
  sign,
  hint,
  answer,
}
enum PicturePuzzleShapeType {
  CIRCLE,
  SQUARE,
  TRIANGLE,
}

class PicturePuzzle {
  List<PicturePuzzleShapeList> list;
  int answer;

  PicturePuzzle(this.list, this.answer);

  @override
  String toString() {
    return 'PicturePuzzle{list: $list}';
  }
}

class PicturePuzzleShapeList {
  List<PicturePuzzleShape> shapeList;

  PicturePuzzleShapeList(this.shapeList);

  @override
  String toString() {
    return 'PicturePuzzleShapeList{shapeList: $shapeList}';
  }
}

class PicturePuzzleShape {
  PicturePuzzleShapeType? picturePuzzleShapeType;
  String text;
  final PicturePuzzleQuestionItemType type;

  PicturePuzzleShape({
    this.picturePuzzleShapeType,
    required this.text,
    required this.type,
  });
}

class PicturePuzzleData {
  PicturePuzzleShapeType picturePuzzleShapeType1;
  String sign1;
  PicturePuzzleShapeType picturePuzzleShapeType2;
  String sign2;
  PicturePuzzleShapeType picturePuzzleShapeType3;
  String text;

  PicturePuzzleData(
      this.picturePuzzleShapeType1,
      this.sign1,
      this.picturePuzzleShapeType2,
      this.sign2,
      this.picturePuzzleShapeType3,
      this.text);

  @override
  String toString() {
    return 'PicturePuzzleData{picturePuzzleShapeType1: $picturePuzzleShapeType1, sign1: $sign1, picturePuzzleShapeType2: $picturePuzzleShapeType2, sign2: $sign2, picturePuzzleShapeType3: $picturePuzzleShapeType3, text: $text}';
  }
}
