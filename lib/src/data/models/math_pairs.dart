class MathPairs {
  List<Pair> list;
  int availableItem;

  MathPairs(this.list, this.availableItem);

  @override
  String toString() {
    return 'MathPairs{list: $list}';
  }
}

class Pair {
  int uid;
  String text;
  bool isActive;
  bool isVisible;

  Pair(this.uid, this.text, this.isActive, this.isVisible);

  @override
  String toString() {
    return 'Pair{text: $text, uid: $uid}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair &&
          runtimeType == other.runtimeType &&
          text == other.text;

  @override
  int get hashCode => text.hashCode;
}
