
import 'package:mathgame/src/core/app_constant.dart';

class AlertRequest {
  final GameCategoryType gameCategoryType;
  final String type;
  final double score;
  final double coin;
  final bool isPause;

  AlertRequest({required this.type,required this.gameCategoryType,required this.score,required this.coin,required this.isPause});
}
