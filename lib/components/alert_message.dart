import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  const AlertMessage({super.key, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Icon(icon, color: icon == Icons.check ? Colors.green : Colors.red)
      ],
    );
  }
}
