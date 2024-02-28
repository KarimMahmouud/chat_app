import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat/screen/chat.dart';
import 'firebase_options.dart';
import 'screen/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: fireBase.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Chat();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
