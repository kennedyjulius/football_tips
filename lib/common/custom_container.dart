import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_tips/common/reusable_text_widget.dart';

class CustomContainer extends StatelessWidget {
  final List<String> imagePaths;

  const CustomContainer({
    super.key,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imagePaths.length, // Use user-provided images count
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("You tapped item $index");
          },
          child: Container(
            height: 150.h,
            width: 120.w,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePaths[index]), // Use provided image
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 0.1,
                color: Colors.black12,
              ),
              color: Colors.amber,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ReusableText(text: "Sure Bets $index"),
            ),
          ),
        );
      },
    );
  }
}
