import 'package:mathgame/src/models/scoreboard/Scoreboard.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';

class GameCategory {
  int id;
  String name;
  String key;
  GameCategoryType gameCategoryType;
  Scoreboard scoreboard;

  GameCategory(
      this.id, this.name, this.key, this.gameCategoryType, this.scoreboard);
}
