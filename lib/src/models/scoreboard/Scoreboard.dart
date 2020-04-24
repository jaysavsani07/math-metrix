class Scoreboard {
  int highestScore;
  int coin;
  bool firstTime;

  Scoreboard(this.highestScore);

  Scoreboard.fromJson(Map<String, dynamic> json)
      : highestScore = json['highestScore'] ?? 0,
        coin = json['coin'] ?? 0,
        firstTime = json['firstTime'] ?? true;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highestScore'] = this.highestScore;
    data['coin'] = this.coin;
    data['firstTime'] = this.firstTime;
    return data;
  }
}
