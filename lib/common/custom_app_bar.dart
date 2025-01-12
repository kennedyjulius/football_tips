import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_tips/utils/app_constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //final UserLocationController controller = Get.put(UserLocationController());
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(
          top: 20.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: kSecondary,
                  backgroundImage: const NetworkImage("https://d326fntlu7tb1e.cloudfront.net/uploads/bdec9d7d-0544-4fc4-823d-3b898f6dbbbf"),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 6,
                    left: 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Deliver to",
                        style: TextStyle(
                          fontSize: 13,
                          color: kSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.65,
                        child: Text(
                          
                             "Heelo there",
                          style: const TextStyle(
                            fontSize: 11,
                            color: kGrayLight,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              getTimeOfDay(),
              style: const TextStyle(
                fontSize: 35,
              ),
            )
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour >= 0 && hour < 12) {
      return ' * ';
    } else if (hour >= 12 && hour < 16) {
      return ' ⛅ ';
    } else {
      return '🌙';
    }
  }
}