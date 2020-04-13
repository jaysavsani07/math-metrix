class SignQandS {
  int id;
  String firstDigit;
  String sign;
  String secondDigit;
  String answer;

  SignQandS(this.id, this.firstDigit, this.sign, this.secondDigit, this.answer);

  @override
  String toString() {
    return 'SignQandS{id: $id, firstDigit: $firstDigit, sign: $sign, secondDigit: $secondDigit, answer: $answer}';
  }
}
