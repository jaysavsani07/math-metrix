class Scoreboard {
  int highestScore;

  Scoreboard(this.highestScore);

  Scoreboard.fromJson(Map<String, dynamic> json)
      : highestScore = json['highestScore'] ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highestScore'] = this.highestScore;
    return data;
  }
}
