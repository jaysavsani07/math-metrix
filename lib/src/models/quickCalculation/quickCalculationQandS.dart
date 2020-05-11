class QuickCalculationQandS {
  String question;
  String userAnswer;
  int answer;

  QuickCalculationQandS(this.question, this.answer) {
    this.userAnswer = "";
  }

  @override
  String toString() {
    return 'QuickCalculationQandS{question: $question, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickCalculationQandS &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}
