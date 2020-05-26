class PicturePuzzleQandS {
  List<PicturePuzzle> list;
  int answer;

  PicturePuzzleQandS(this.list, this.answer);

  @override
  String toString() {
    return 'PicturePuzzleQandS{list: $list}';
  }
}

class PicturePuzzle {
  List<PicturePuzzleShape> shapeList;

  PicturePuzzle(this.shapeList);

  @override
  String toString() {
    return 'PicturePuzzle{shapeList: $shapeList}';
  }
}

class PicturePuzzleShape {
  bool isSign;
  bool isAnswer;
  PicturePuzzleShapeType picturePuzzleShapeType;
  String text;

  PicturePuzzleShape({this.isSign, this.picturePuzzleShapeType, this.isAnswer,this.text});

  @override
  String toString() {
    return 'PicturePuzzleShape{isSign: $isSign, picturePuzzleShapeType: $picturePuzzleShapeType, sign: $text}';
  }
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

enum PicturePuzzleShapeType { CIRCLE, SQUARE, TRIANGLE }
