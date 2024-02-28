// ignore_for_file: file_names
class QizeQuestions {
  QizeQuestions({required this.text, required this.answers});

  final String text;
  final List<String> answers;

  List<String> getshuffledAnswers() {
    final listShuffled = List.of(answers);
    listShuffled.shuffle();
    return listShuffled;
  }
}
