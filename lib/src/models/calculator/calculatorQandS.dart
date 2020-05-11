class CalculatorQandS {
  String question;
  int answer;

  CalculatorQandS(this.question, this.answer);

  @override
  String toString() {
    return 'CalculatorQandS{question: $question, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculatorQandS &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}
