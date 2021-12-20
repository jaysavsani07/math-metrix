class Calculator {
  String question;
  int answer;

  Calculator(this.question, this.answer);

  @override
  String toString() {
    return 'Calculator{question: $question, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Calculator &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}
