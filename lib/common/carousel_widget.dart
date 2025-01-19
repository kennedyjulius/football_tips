import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_tips/models/model_tips.dart';

class CarouselWidget extends StatefulWidget {
  final List<Tip> tips;

  const CarouselWidget({super.key, required this.tips});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.tips.length,
          itemBuilder: (context, index, realIndex) {
            return _buildTipCard(widget.tips[index], index == _currentIndex);
          },
          options: CarouselOptions(
            height: 220.h,
            viewportFraction: 0.92,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 6.h),
        DotsIndicator(
          dotsCount: widget.tips.length,
          position: _currentIndex,
          decorator: DotsDecorator(
            size: Size.square(8.r),
            activeSize: Size(24.w, 8.h),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            activeColor: Colors.orange.shade400,
            color: Colors.grey.shade600,
            spacing: EdgeInsets.all(4.w),
          ),
        ),
      ],
    );
  }

  Widget _buildTipCard(Tip tip, bool isHighlighted) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isHighlighted
              ? [Colors.deepOrange.shade900, Colors.red.shade900]
              : [Colors.indigo.shade900, Colors.purple.shade900],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: isHighlighted
                ? Colors.orange.withOpacity(0.3)
                : Colors.purple.withOpacity(0.3),
            blurRadius: 16,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(15.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoChip(
                        icon: Icons.calendar_today,
                        text: tip.date,
                      ),
                      if (isHighlighted) _buildHotTipBadge(),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${tip.team1} vs ${tip.team2}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isHighlighted ? 20.sp : 18.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      _buildOddsContainer(tip.odds),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _buildInfoChip(
                        icon: Icons.sports_soccer_outlined,
                        text: tip.leagueName,
                      ),
                      _buildInfoChip(
                        icon: Icons.access_time,
                        text: tip.time,
                      ),
                      _buildInfoChip(
                        icon: Icons.sports_soccer,
                        text: tip.tipsName,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  _buildStatusAndResults(tip),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHotTipBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade400,
            Colors.orange.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department, color: Colors.white70),
          SizedBox(width: 4.w),
          Text(
            'HOT TIP',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 16.sp),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildOddsContainer(String odds) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        odds,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusAndResults(Tip tip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Status: ${tip.status}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
          ),
        ),
        Text(
          'Result: ${tip.results}',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
