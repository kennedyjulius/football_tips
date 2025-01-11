import 'package:flutter/material.dart';
import 'dart:math';

class CurvedOscillatingMarquee extends StatefulWidget {
  final String text;

  const CurvedOscillatingMarquee({Key? key, required this.text}) : super(key: key);

  @override
  _CurvedOscillatingMarqueeState createState() => _CurvedOscillatingMarqueeState();
}

class _CurvedOscillatingMarqueeState extends State<CurvedOscillatingMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _scrollPosition;

  @override
  void initState() {
    super.initState();
    _scrollPosition = 0.0;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12), // Slower animation
    )..addListener(() {
        setState(() {
          _scrollPosition = _controller.value * 2 * pi;
        });
      });

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30, // Reduced height since we don't need as much vertical space
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: CustomPaint(
        painter: LinearMarqueePainter(
          text: widget.text,
          scrollPosition: _scrollPosition,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LinearMarqueePainter extends CustomPainter {
  final String text;
  final double scrollPosition;
  static const double curveStrength = 10.0; // Reduced curve strength

  LinearMarqueePainter({required this.text, required this.scrollPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final width = size.width;
    final height = size.height;
    final centerY = height / 2;

    final totalChars = text.length;
    for (int i = 0; i < totalChars; i++) {
      final progress = i / totalChars;
      final charPosition = progress * width;
      
      // Calculate linear position with scroll
      final normalizedPos = (charPosition - (scrollPosition * 50)) % width; // Slower movement
      final relativePos = normalizedPos / width;

      // Calculate vertical offset only at the ends
      double verticalOffset = 0.0;
      if (relativePos < 0.1) {
        // Curve at the start
        verticalOffset = sin(relativePos * pi / 0.1) * curveStrength * (0.1 - relativePos) / 0.1;
      } else if (relativePos > 0.9) {
        // Curve at the end
        verticalOffset = sin((1 - relativePos) * pi / 0.1) * curveStrength * (relativePos - 0.9) / 0.1;
      }

      final charX = normalizedPos;
      final charY = centerY + verticalOffset;

      // Set text properties with minimal variation
      textPainter.text = TextSpan(
        text: text[i],
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: Color.fromRGBO(0, 0, 0, 0.3),
            ),
          ],
        ),
      );
      textPainter.layout();

      // Apply minimal rotation only at the ends
      canvas.save();
      canvas.translate(charX, charY);
      
      double rotationAngle = 0.0;
      if (relativePos < 0.1) {
        rotationAngle = 0.2 * (0.1 - relativePos) / 0.1;
      } else if (relativePos > 0.9) {
        rotationAngle = 0.2 * (relativePos - 0.9) / 0.1;
      }
      
      canvas.rotate(rotationAngle);
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}