import 'package:flutter/widgets.dart';
import 'package:mathgame/src/models/scoreboard/Scoreboard.dart';

import 'models/gameCategory.dart';

class HomeViewModel extends ChangeNotifier {
  List<GameCategory> _list;

  List<GameCategory> get list => _list;

  void initialise() {
    _list = List();
    list.add(GameCategory(1, "Calculator", Scoreboard(0)));
    list.add(GameCategory(2, "What's the sign?", Scoreboard(0)));
    list.add(GameCategory(3, "Square root", Scoreboard(0)));
    list.add(GameCategory(4, "Mathematical pairs", Scoreboard(0)));
    list.add(GameCategory(5, "Correct answer", Scoreboard(0)));
    list.add(GameCategory(6, "Magic triangle", Scoreboard(0)));
    list.add(GameCategory(7, "Mental arithmetic", Scoreboard(0)));
    list.add(GameCategory(8, "Quick calculation", Scoreboard(0)));
    list.add(GameCategory(9, "Math Machine Square", Scoreboard(0)));
    notifyListeners();
  }
}
