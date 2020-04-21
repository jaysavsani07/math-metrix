import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:provider/provider.dart';
import 'SingleDigitCounter.dart';


class MultipleDigitCounter extends StatefulWidget {
  int initialValue;
  int numberOfDigits;
  bool expandable;
  final TextStyle textStyle;
  final BoxDecoration boxDecoration;

  //MultipleDigitCounterState _state;

  /// state has to be accessible so that the value is accessible from the parent widget
  //MultipleDigitCounterState get state => _state;

  MultipleDigitCounter(this.numberOfDigits, this.expandable, this.textStyle,
      this.initialValue, this.boxDecoration,
      {Key key})
      : super(key: key);

  @override
  MultipleDigitCounterState createState() {
    return MultipleDigitCounterState(this.numberOfDigits, this.expandable,
        this.initialValue, this.textStyle, this.boxDecoration);
  }
}

class MultipleDigitCounterState extends State<MultipleDigitCounter> {
  int numberOfDigits;
  bool expandable;
  int _value;
  final TextStyle _textStyle;
  final BoxDecoration _boxDecoration;

  List<SingleDigit> animatedDigits = [];

  String _oldValue;
  String _newValue;

  int get value => _value;

  set value(int newValue) {
    _oldValue = value.toString();
    while (_oldValue.length < numberOfDigits) {
      _oldValue = '0$_oldValue';
    }

    _value = newValue;

    _newValue = newValue.toString();
    while (_newValue.length < numberOfDigits) {
      _newValue = '0$_newValue';
    }

    setState(() {
      for (var i = 0; i < numberOfDigits; i++) {
        if (_oldValue[i] != _newValue[i]) {
          animatedDigits[i].setValue(int.parse(_newValue[i]));
        }
      }
    });
  }

  String getValueAsString() {
    String val = _value.toString();
    while (val.length < numberOfDigits) {
      val = '0$val';
    }
    return val;
  }

  MultipleDigitCounterState(this.numberOfDigits, this.expandable, this._value,
      this._textStyle, this._boxDecoration);

  @override
  Widget build(BuildContext context) {

    if (animatedDigits.isEmpty) {
      String newValue = getValueAsString();

      for (var i = 0; i < newValue.length; i++) {
        var initialDigit = 0;
        if (_oldValue != null && _oldValue.length > i) {
          initialDigit = int.parse(_oldValue[i]);
        }
        animatedDigits.add(SingleDigit(initialValue: initialDigit));
      }
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: animatedDigits);
  }
}
