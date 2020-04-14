class CorrectAnswerQandS {
  int id;
  String question;
  String firstAns;
  String secondAns;
  String thirdAns;
  String fourthAns;
  int answer;

  CorrectAnswerQandS(this.id, this.question, this.firstAns, this.secondAns,
      this.thirdAns, this.fourthAns, this.answer);

  @override
  String toString() {
    return 'CorrectAnswerQandS{id: $id, question: $question, firstAns: $firstAns, secondAns: $secondAns, thirdAns: $thirdAns, fourthAns: $fourthAns, answer: $answer}';
  }
}
