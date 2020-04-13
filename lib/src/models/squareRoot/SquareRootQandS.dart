class SquareRootQandS {
  int id;
  String question;
  String firstAns;
  String secondAns;
  String thirdAns;
  String fourthAns;
  int answer;

  SquareRootQandS(this.id, this.question, this.firstAns, this.secondAns,
      this.thirdAns, this.fourthAns, this.answer);

  @override
  String toString() {
    return 'SignQandS{id: $id, question: $question, firstAns: $firstAns, secondAns: $secondAns, thirdAns: $thirdAns, fourthAns: $fourthAns, answer: $answer}';
  }
}
