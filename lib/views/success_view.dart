import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  final String message;

  const SuccessView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 26, 
            fontWeight: FontWeight.bold, 
            color: Colors.green
          ),
        ),
      ),
    );
  }
}