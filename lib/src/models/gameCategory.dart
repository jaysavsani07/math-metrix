import 'package:mathgame/src/models/scoreboard/Scoreboard.dart';

class GameCategory {
  int id;
  String name;
  Scoreboard scoreboard;

  GameCategory(this.id, this.name, this.scoreboard);
}
