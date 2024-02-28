import 'package:flutter/material.dart';
import 'package:recav/data/questions.dart';
import 'package:percent_indicator/percent_indicator.dart';

// ignore: must_be_immutable
class Result extends StatefulWidget {
  Result(this.selectedAnswer, this.restart, {super.key});

  final List<String> selectedAnswer;
  void Function(BuildContext ctx) restart;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List<Map<String, Object>> getSummryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < widget.selectedAnswer.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': widget.selectedAnswer[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    var res = 0;
    for (int i = 0; i < getSummryData().length; i++) {
      if (getSummryData()[i]['user_answer'] ==
          getSummryData()[i]['correct_answer']) {
        res++;
      } else {
        res += 0;
      }
    }

    double val = 0;
    for (int i = 0; i < getSummryData().length; i++) {
      if (i == questions.length) {
        break;
      }
      if (getSummryData()[i]['user_answer'] ==
          getSummryData()[i]['correct_answer']) {
        val += 1.0;
      }
    }
    val = val / questions.length;

    return Scaffold(
      body: Container(
        height: double.infinity,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "You answered $res out of ${questions.length} questions correctly",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                res == questions.length
                    ? const Icon(Icons.done_all)
                    : const Text(""),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 47.0,
                      lineWidth: 8.0,
                      percent: val, //>> 0.0 : 1.0
                      center: Text(
                        "${(res * 100) / questions.length}%",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.white,
                      progressColor: const Color.fromARGB(255, 0, 0, 0),
                      animation: true,
                      animationDuration: 1500,
                      circularStrokeCap: CircularStrokeCap.butt,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 350,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ...getSummryData().map(
                      (e) => Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: e['user_answer'] ==
                                        e['correct_answer']
                                    ? const Color.fromARGB(255, 33, 119, 168)
                                    : const Color.fromARGB(255, 208, 0, 0),
                                child: Text(
                                  ((e['question_index'] as int) + 1).toString(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      e['question'].toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 168, 32, 32),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6.5,
                                    ),
                                    Row(
                                      children: [
                                        const Text("     "),
                                        Text(
                                          e['user_answer'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 124, 19, 85),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        e['user_answer'] == e['correct_answer']
                                            ? const Icon(
                                                Icons.task_alt,
                                                color: Color.fromARGB(
                                                    255, 40, 255, 104),
                                              )
                                            : const Icon(
                                                Icons.highlight_off,
                                                color: Color.fromARGB(
                                                    255, 208, 0, 0),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      e['correct_answer'].toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 31, 77, 228),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ), // map dy haga zay loop btlf 3la kol elememt w ta3rdo (e) == i loop
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => widget.restart(context),
                  icon: const Icon(
                    Icons.restart_alt,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Restart Quiz!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
