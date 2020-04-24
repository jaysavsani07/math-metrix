import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';

class AlertRequest {
  final GameCategoryType gameCategoryType;
  final String type;
  final double score;
  final double coin;
  final bool isPause;

  AlertRequest({this.type,this.gameCategoryType, this.score, this.coin, this.isPause});
}
