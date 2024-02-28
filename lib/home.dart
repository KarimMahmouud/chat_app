import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
            Image.asset(
              "images/b.png",
              height: 250,
            ),
            const SizedBox(height: 80),
            Text(
              "Learn Flutter !",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "next");
              },
              icon: const Icon(
                Icons.arrow_right_alt_outlined,
                color: Colors.white,
              ),
              label: Text(
                "Start Quiz",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
