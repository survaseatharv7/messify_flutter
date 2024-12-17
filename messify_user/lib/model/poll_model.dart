class Poll {
  static String question = "Vote for Today's Menu";
  int optionCount;
  String options;
  Poll({required question, required this.optionCount, required this.options}) {
    Poll.question = question;
  }
}
