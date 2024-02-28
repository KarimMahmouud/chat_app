// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/questions.dart';
import 'models/answer_button.dart';

class Questions extends StatefulWidget {
  const Questions(this.onSelectedAnswer, {super.key});

  final Function(String, BuildContext newContext) onSelectedAnswer;

  @override
  State<Questions> createState() => _QuetionsState();
}

class _QuetionsState extends State<Questions> {
  int index = 0;

  void answerQuestions(String answer) {
    widget.onSelectedAnswer(answer, context);
    if (index < 3) {
      setState(() {
        index++;
      });
    } else if (index > 3) {
      setState(() {
        index = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cuurenQuestion = questions[index];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.cyan,
              Colors.black12,
            ],
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              cuurenQuestion.text,
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ...cuurenQuestion.getshuffledAnswers().map(
              (e) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  child: AnswerButton(
                    answerText: e,
                    onPressed: () => answerQuestions(e),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
