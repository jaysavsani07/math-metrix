class MentalArithmeticQandS {
  int id;
  String currentQuestion;
  List<String> questionList;
  int answer;
  int answerLength;

  MentalArithmeticQandS(this.id, this.questionList, this.answer) {
    this.currentQuestion = questionList[0];
    this.answerLength = answer.toString().trim().length;
  }

  @override
  String toString() {
    return 'CalculatorQandS{id: $id, question: $questionList, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MentalArithmeticQandS &&
              runtimeType == other.runtimeType &&
              currentQuestion == other.currentQuestion;

  @override
  int get hashCode => currentQuestion.hashCode;


}
