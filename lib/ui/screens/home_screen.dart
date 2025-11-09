import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: TextSpan(
            text: "Dont have an account ?",
            style: TextStyle(color: Colors.grey.shade900),
            children: [
              TextSpan(
                text: "Sign In",
                style: TextStyle(color: Colors.green.shade700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
