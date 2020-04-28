class QuickCalculationQandS {
  int id;
  String question;
  String userAnswer;
  int answer;

  QuickCalculationQandS(this.id, this.question, this.answer) {
    this.userAnswer = "";
  }

  @override
  String toString() {
    return 'QuickCalculationQandS{id: $id, question: $question, answer: $answer}';
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
