import 'package:mathgame/src/models/whatsTheSign/SignQandS.dart';

class SignQandSDataProvider {
  static getSignDataList() {
    List<SignQandS> list = List();

    list.add(SignQandS(1, "5", "+", "4", "9"));
    list.add(SignQandS(2, "5", "-", "4", "1"));
    list.add(SignQandS(3, "5", "*", "4", "20"));
    list.add(SignQandS(4, "4", "/", "4", "1"));
    list.add(SignQandS(5, "8", "+", "4", "12"));
    list.add(SignQandS(5, "7", "-", "6", "1"));
    list.add(SignQandS(5, "11", "+", "4", "15"));
    list.add(SignQandS(5, "27", "+", "5", "32"));
    list.add(SignQandS(5, "19", "-", "17", "2"));
    list.add(SignQandS(5, "7", "*", "9", "63"));
    list.add(SignQandS(5, "55", "/", "5", "11"));
    list.add(SignQandS(5, "42", "-", "7", "35"));
    list.add(SignQandS(5, "26", "+", "6", "32"));
    list.add(SignQandS(5, "72", "-", "8", "64"));
    list.add(SignQandS(5, "54", "-", "23", "31"));

    return list;
  }
}
