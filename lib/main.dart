import 'package:flutter/material.dart';
import 'package:quizz/accueil.dart';
import 'package:quizz/quizz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz App',
      //home: Acceuil(),
      //home: Quizz(),
      initialRoute: '/accueil',
      routes: {
        '/accueil': (context) => Acceuil(),
        '/home': (context) => Quiz(),
      },
    );
  }
}
