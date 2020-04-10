class CalculatorQandS {
  int id;
  String question;
  int answer;

  CalculatorQandS(this.id, this.question, this.answer);

  @override
  String toString() {
    return 'CalculatorQandS{id: $id, question: $question, answer: $answer}';
  }
}
