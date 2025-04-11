import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  SmallButton({required this.text, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: Size(50, 30),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}