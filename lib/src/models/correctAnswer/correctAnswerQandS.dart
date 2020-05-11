class CorrectAnswerQandS {
  String question;
  String firstAns;
  String secondAns;
  String thirdAns;
  String fourthAns;
  int answer;

  CorrectAnswerQandS(this.question, this.firstAns, this.secondAns,
      this.thirdAns, this.fourthAns, this.answer);

  @override
  String toString() {
    return 'CorrectAnswerQandS{question: $question, firstAns: $firstAns, secondAns: $secondAns, thirdAns: $thirdAns, fourthAns: $fourthAns, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrectAnswerQandS &&
          runtimeType == other.runtimeType &&
          question == other.question;

  @override
  int get hashCode => question.hashCode;
}
