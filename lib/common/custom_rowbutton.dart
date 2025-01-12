import 'package:flutter/material.dart';

class RowWithButton extends StatelessWidget {
  final String startText; // Text on the left
  final String buttonText; // Text on the button
  final VoidCallback onButtonPressed; // Callback when button is pressed

  const RowWithButton({
    Key? key,
    required this.startText,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Adds some spacing around the row
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
        children: [
          // Left text
          Text(
            startText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Right button
          TextButton(
            onPressed: onButtonPressed,
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue, // Button text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
