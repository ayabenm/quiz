import 'package:flutter/material.dart';

class Acceuil extends StatelessWidget {
  const Acceuil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizedBox(height: 100),
          Text(
            "Welcome!",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          Image.asset('assets/img/img1.jpg'),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Text(
              "Get Started",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors
                    .blue[700], // Removed the const and dynamic value issue
              ),
            ),
          ),
        ],
      ),
    );
  }
}
