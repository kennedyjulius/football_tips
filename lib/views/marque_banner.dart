// import 'package:flutter/material.dart';
// import 'dart:math';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CurvedOscillatingMarquee extends StatefulWidget {
//   final String text;

//   const CurvedOscillatingMarquee({Key? key, required this.text}) : super(key: key);

//   @override
//   _CurvedOscillatingMarqueeState createState() => _CurvedOscillatingMarqueeState();
// }

// class _CurvedOscillatingMarqueeState extends State<CurvedOscillatingMarquee>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late double _scrollPosition;

//   @override
//   void initState() {
//     super.initState();
//     _scrollPosition = 0.0;

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 12), // Slower animation
//     )..addListener(() {
//         setState(() {
//           _scrollPosition = _controller.value * 2 * pi;
//         });
//       });

//     _controller.repeat();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30.h, // Reduced height since we don't need as much vertical space
//       width: double.maxFinite,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: Colors.blueAccent,
//         borderRadius: BorderRadius.circular(15.r),
//       ),
//       child: CustomPaint(
//         painter: LinearMarqueePainter(
//           text: widget.text,
//           scrollPosition: _scrollPosition,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class LinearMarqueePainter extends CustomPainter {
//   final String text;
//   final double scrollPosition;
//   static const double curveStrength = 10.0; // Reduced curve strength

//   LinearMarqueePainter({required this.text, required this.scrollPosition});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//     );

//     final width = size.width;
//     final height = size.height;
//     final centerY = height / 2;

//     final totalChars = text.length;
//     for (int i = 0; i < totalChars; i++) {
//       final progress = i / totalChars;
//       final charPosition = progress * width;
      
//       // Calculate linear position with scroll
//       final normalizedPos = (charPosition - (scrollPosition * 50)) % width; // Slower movement
//       final relativePos = normalizedPos / width;

//       // Calculate vertical offset only at the ends
//       double verticalOffset = 0.0;
//       if (relativePos < 0.1) {
//         // Curve at the start
//         verticalOffset = sin(relativePos * pi / 0.1) * curveStrength * (0.1 - relativePos) / 0.1;
//       } else if (relativePos > 0.9) {
//         // Curve at the end
//         verticalOffset = sin((1 - relativePos) * pi / 0.1) * curveStrength * (relativePos - 0.9) / 0.1;
//       }

//       final charX = normalizedPos;
//       final charY = centerY + verticalOffset;

//       // Set text properties with minimal variation
//       textPainter.text = TextSpan(
//         text: text[i],
//         style: const TextStyle(
//           fontSize: 16.0,══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
// The following _TypeError was thrown building StreamBuilder<QuerySnapshot<Map<String,
// dynamic>>>(dirty, state: _StreamBuilderBaseState<QuerySnapshot<Map<String, dynamic>>,
// AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>>#827d1):
// type 'double' is not a subtype of type 'String'

// The relevant error-causing widget was:
//   StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
//   StreamBuilder:file:///home/kennedymutugi/Desktop/flutter%20projects/football_tips/lib/views/gamecategory_screen.dart:107:22

// When the exception was thrown, this was the stack:
// #0      new Tip.fromFirestore (package:football_tips/models/model_tips.dart:51:26)
// #1      _GameCategoriesScreenState.build.<anonymous closure>.<anonymous closure>.<anonymous closure> (package:football_tips/views/gamecategory_screen.dart:119:54)
// #2      MappedListIterable.elementAt (dart:_internal/iterable.dart:435:31)
// #3      ListIterator.moveNext (dart:_internal/iterable.dart:364:26)
// #4      new _GrowableList._ofEfficientLengthIterable (dart:core-patch/growable_array.dart:189:27)
// #5      new _GrowableList.of (dart:core-patch/growable_array.dart:150:28)
// #6      new List.of (dart:core-patch/array_patch.dart:39:18)
// #7      ListIterable.toList (dart:_internal/iterable.dart:224:7)
// #8      _GameCategoriesScreenState.build.<anonymous closure>.<anonymous closure> (package:football_tips/views/gamecategory_screen.dart:119:74)
// #9      StreamBuilder.build (package:flutter/src/widgets/async.dart:454:81)
// #10     _StreamBuilderBaseState.build (package:flutter/src/widgets/async.dart:123:48)
// #11     StatefulElement.build (package:flutter/src/widgets/framework.dart:5743:27)
// #12     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5631:15)
// #13     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5794:11)
// #14     Element.rebuild (package:flutter/src/widgets/framework.dart:5347:7)
// #15     BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2694:15)
// #16     BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2753:11)
// #17     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3048:18)
// #18     WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1176:21)
// #19     RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:475:5)
// #20     SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1397:15)
// #21     SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1318:9)
// #22     SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1176:5)
// #23     _invoke (dart:ui/hooks.dart:312:13)
// #24     PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:427:5)
// #25     _drawFrame (dart:ui/hooks.dart:283:31)

// ════════════════════════════════════════════════════════════════════════════════════════════════════

//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           shadows: [
//             Shadow(
//               offset: Offset(1, 1),
//               blurRadius: 2,
//               color: Color.fromRGBO(0, 0, 0, 0.3),
//             ),
//           ],
//         ),
//       );
//       textPainter.layout();

//       // Apply minimal rotation only at the ends
//       canvas.save();
//       canvas.translate(charX, charY);
      
//       double rotationAngle = 0.0;
//       if (relativePos < 0.1) {
//         rotationAngle = 0.2 * (0.1 - relativePos) / 0.1;
//       } else if (relativePos > 0.9) {
//         rotationAngle = 0.2 * (relativePos - 0.9) / 0.1;
//       }
      
//       canvas.rotate(rotationAngle);
//       textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
//       canvas.restore();
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }