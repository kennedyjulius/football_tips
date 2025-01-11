import 'package:flutter/material.dart';

class MarqueeBanner extends StatefulWidget {
  final String text;
  MarqueeBanner({required this.text});

  @override
  _MarqueeBannerState createState() => _MarqueeBannerState();
}

class _MarqueeBannerState extends State<MarqueeBanner> {
  late double _width;
  late double _scrollPosition;

  @override
  void initState() {
    super.initState();
    _scrollPosition = 0.0; // Initial scroll position
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _width = constraints.maxWidth;
        return AnimatedBuilder(
          animation: Listenable.merge([ValueNotifier(1)]), // Keeps animation moving
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  left: _scrollPosition,
                  top: 0,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Call this method when you want to start the scrolling
  void startScroll() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _scrollPosition -= 1.0; // Move the text to the left
      });

      if (_scrollPosition < -_width) {
        // Reset the position when the text moves off the screen
        _scrollPosition = _width;
      }
      startScroll(); // Keep scrolling in a loop
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startScroll(); // Start the scroll animation
  }
}