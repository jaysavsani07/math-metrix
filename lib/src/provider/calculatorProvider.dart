import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/resources/calculator/calculatorQandSDataProvider.dart';

class CalculatorProvider with ChangeNotifier {
  List<CalculatorQandS> _list;
  CalculatorQandS _currentState;
  int _index = 0;

  CalculatorQandS get currentState => _currentState;

  CalculatorProvider() {
    _list = CalculatorQandSDataProvider.getCalculatorDataList();
    _currentState = _list[_index];
  }

  void checkResult(String answer) {
    if (int.parse(answer) == _currentState.answer) {
      _currentState = _list[++_index];
      notifyListeners();
    } else {}
  }
}
