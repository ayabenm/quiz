import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String selectedAnswer1 = '';
  String selectedAnswer2 = '';
  String selectedAnswer3 = '';

  final String correctAnswer1 = 'tunis';
  final String correctAnswer2 = '1912';
  final String correctAnswer3 = 'Jupiter';

  int score = 0;

  final Color primaryColor = Colors.deepPurpleAccent;
  final Color secondaryColor = Colors.deepPurple[200]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 105, 141),
        title: const Text('App Quizz'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.air_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(children: [
          const Text("Menu", style: TextStyle(fontSize: 36)),
          TextButton(
            onPressed: () {
              // Navigate to the AccueilPage
              Navigator.pushNamed(context, '/accueil');
            },
            child: const Text(
              "AccueilPage",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.pink,
              ),
            ),
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _getProgress(),
              backgroundColor: secondaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
            SizedBox(height: 20),
            _buildQuestionCard(
              question: '1. What is the capital of Tunisia?',
              options: ['sousse', 'tunis', 'Mahdia'],
              selectedAnswer: selectedAnswer1,
              correctAnswer: correctAnswer1,
              questionNumber: 1,
            ),
            SizedBox(height: 20),
            _buildQuestionCard(
              question: '2. What year did the Titanic sink?',
              options: ['1912', '1905', '1980'],
              selectedAnswer: selectedAnswer2,
              correctAnswer: correctAnswer2,
              questionNumber: 2,
            ),
            SizedBox(height: 20),
            _buildQuestionCard(
              question: '3. What is the largest planet in our solar system?',
              options: ['Earth', 'Jupiter', 'Saturn'],
              selectedAnswer: selectedAnswer3,
              correctAnswer: correctAnswer3,
              questionNumber: 3,
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _isQuizComplete()
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(score: score),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit Quiz',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard({
    required String question,
    required List<String> options,
    required String selectedAnswer,
    required String correctAnswer,
    required int questionNumber,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 10,
              children: options.map((option) {
                return _buildOptionButton(
                    option, selectedAnswer, correctAnswer, questionNumber);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, String selectedAnswer,
      String correctAnswer, int questionNumber) {
    Color buttonColor = const Color.fromARGB(255, 41, 136, 128);

    if (selectedAnswer.isNotEmpty) {
      if (selectedAnswer == text) {
        buttonColor =
            selectedAnswer == correctAnswer ? Colors.green : Colors.red;
      }
    }

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (questionNumber == 1) {
            selectedAnswer1 = text;
            if (text == correctAnswer1) {
              score++;
            }
          } else if (questionNumber == 2) {
            selectedAnswer2 = text;
            if (text == correctAnswer2) {
              score++;
            }
          } else if (questionNumber == 3) {
            selectedAnswer3 = text;
            if (text == correctAnswer3) {
              score++;
            }
          }
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontFamily: 'Montserrat'),
      ),
    );
  }

  bool _isQuizComplete() {
    return selectedAnswer1.isNotEmpty &&
        selectedAnswer2.isNotEmpty &&
        selectedAnswer3.isNotEmpty;
  }

  double _getProgress() {
    int totalAnswered = 0;
    if (selectedAnswer1.isNotEmpty) totalAnswered++;
    if (selectedAnswer2.isNotEmpty) totalAnswered++;
    if (selectedAnswer3.isNotEmpty) totalAnswered++;
    return totalAnswered / 3;
  }
}

class ResultPage extends StatelessWidget {
  final int score;

  const ResultPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 77, 175),
        title: const Text('Quiz Results',
            style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            const SizedBox(height: 20),
            Text(
              '$score/3',
              style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
