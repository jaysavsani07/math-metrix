import 'package:mathgame/src/models/picturePuzzle/PicturePuzzleRootQandS.dart';

class PicturePuzzleQandSDataProvider {
  static List<int> listHasCode = List();

  static getPicturePuzzleDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    int i = 0;
    List<PicturePuzzle> list = List();
    List<PicturePuzzleShape> listShape1 = List();
    List<PicturePuzzleShape> listShape2 = List();
    List<PicturePuzzleShape> listShape3 = List();
    List<PicturePuzzleShape> listShape4 = List();

    listShape1.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.CIRCLE,
        sign: ""));
    listShape1.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape1.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.CIRCLE,
        sign: ""));
    listShape1.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape1.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.SQUARE,
        sign: ""));
    listShape1.add(PicturePuzzleShape(isSign: true, sign: "="));
    listShape1.add(PicturePuzzleShape(isSign: true, sign: "10", answer: 10));
    list.add(PicturePuzzle(listShape1));

    listShape2.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.TRIANGLE,
        sign: ""));
    listShape2.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape2.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.TRIANGLE,
        sign: ""));
    listShape2.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape2.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.SQUARE,
        sign: ""));
    listShape2.add(PicturePuzzleShape(isSign: true, sign: "="));
    listShape2.add(PicturePuzzleShape(isSign: true, sign: "14", answer: 14));
    list.add(PicturePuzzle(listShape2));

    listShape3.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.SQUARE,
        sign: ""));
    listShape3.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape3.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.SQUARE,
        sign: ""));
    listShape3.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape3.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.SQUARE,
        sign: ""));
    listShape3.add(PicturePuzzleShape(isSign: true, sign: "="));
    listShape3.add(PicturePuzzleShape(isSign: true, sign: "16", answer: 16));
    list.add(PicturePuzzle(listShape3));

    listShape4.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.CIRCLE,
        sign: ""));
    listShape4.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape4.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.TRIANGLE,
        sign: ""));
    listShape4.add(PicturePuzzleShape(isSign: true, sign: "+"));
    listShape4.add(PicturePuzzleShape(
        isSign: false,
        picturePuzzleShapeType: PicturePuzzleShapeType.SQUARE,
        sign: ""));
    listShape4.add(PicturePuzzleShape(isSign: true, sign: "="));
    listShape4.add(PicturePuzzleShape(isSign: true, sign: "?", answer: 12));
    list.add(PicturePuzzle(listShape4));

    return <PicturePuzzleQandS>[PicturePuzzleQandS(list, 12)];
  }
}

void main() {
//  for (int i = 1; i < 6; i++) {
  print(PicturePuzzleQandSDataProvider.getPicturePuzzleDataList(1));
//  }
}
