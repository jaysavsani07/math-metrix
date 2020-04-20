class Scoreboard {
  int highestScore;
  int coin;

  Scoreboard(this.highestScore);

  Scoreboard.fromJson(Map<String, dynamic> json)
      : highestScore = json['highestScore'] ?? 0,
        coin = json['coin'] ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highestScore'] = this.highestScore;
    data['coin'] = this.coin;
    return data;
  }
}
