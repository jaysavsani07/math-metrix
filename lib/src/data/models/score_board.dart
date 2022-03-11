class ScoreBoard {
  int highestScore;
  late bool firstTime;

  ScoreBoard({required  this.highestScore});

  ScoreBoard.fromJson(Map<String, dynamic> json)
      : highestScore = json['highestScore'] ?? 0,
        firstTime = json['firstTime'] ?? true;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highestScore'] = this.highestScore;
    data['firstTime'] = this.firstTime;
    return data;
  }
}
