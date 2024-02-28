import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recav/Questions.dart';
import 'package:recav/data/questions.dart';
import 'package:recav/home.dart';
import 'package:recav/result.dart';

class Qize extends StatefulWidget {
  const Qize({super.key});

  @override
  State<Qize> createState() => _QizeState();
}

List<String> selectedAnswer = [];

class _QizeState extends State<Qize> {
  void chooseAnswer(String answer, BuildContext newContext) {
    selectedAnswer.add(answer);
    log(selectedAnswer.toString());

    if (selectedAnswer.length == questions.length) {
      setState(() {
        Navigator.pushNamed(newContext, "result");
      });
    }
  }

  void restart(BuildContext ctx) {
    setState(() {
      selectedAnswer = [];
      Navigator.pushNamed(ctx, "next");
      log(selectedAnswer.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "next": (context) => Questions(chooseAnswer),
        "home": (context) => const Home(),
        "result": (context) => Result(selectedAnswer, restart),
      },
      home: const Home(),
    );
  }
}
