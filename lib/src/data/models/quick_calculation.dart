class QuickCalculation {
  String question;
  late String userAnswer;
   int answer;

  QuickCalculation({required  this.question,required  this.answer}) {
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
