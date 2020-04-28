class MathPairsQandS {
  int id;
  List<MathPair> list;
  int availableItem;

  MathPairsQandS(this.id, this.list, this.availableItem);

  @override
  String toString() {
    return 'MathPairsQandS{id: $id, list: $list}';
  }
}

class MathPair {
  int uid;
  String text;
  bool isActive;
  bool isVisible;

  MathPair(this.uid, this.text, this.isActive, this.isVisible);

  @override
  String toString() {
    return 'MathPairs{text: $text, uid: $uid}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MathPair &&
          runtimeType == other.runtimeType &&
          text == other.text;
}
