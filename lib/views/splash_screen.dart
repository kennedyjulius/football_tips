import 'package:flutter/material.dart';
import 'package:football_tips/views/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      ),
    );
    return const SafeArea(
      child: Material(
        child: Stack(
          children: [
            // Display the image as the splash screen background
            Image(
              image: AssetImage('assets/betting2.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Circular progress indicator at the bottom center
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}