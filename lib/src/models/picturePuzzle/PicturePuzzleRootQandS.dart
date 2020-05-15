class PicturePuzzleQandS {
  List<PicturePuzzle> list;
  int answer;

  PicturePuzzleQandS(this.list,this.answer);

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
  PicturePuzzleShapeType picturePuzzleShapeType;
  String sign;
  int answer;

  PicturePuzzleShape(
      {this.isSign, this.picturePuzzleShapeType, this.sign, this.answer});

  @override
  String toString() {
    return 'PicturePuzzleShape{isSign: $isSign, picturePuzzleShapeType: $picturePuzzleShapeType, sign: $sign, answer: $answer}';
  }
}

enum PicturePuzzleShapeType { CIRCLE, SQUARE, TRIANGLE }
