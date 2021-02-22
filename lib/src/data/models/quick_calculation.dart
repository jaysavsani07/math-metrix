class QuickCalculation {
  String question;
  String userAnswer;
  int answer;

  QuickCalculation(this.question, this.answer) {
    this.userAnswer = "";
  }

  @override
  String toString() {
    return 'QuickCalculationQandS{question: $question, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickCalculation &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}
