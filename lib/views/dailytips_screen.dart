import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_tips/models/matchtip_model.dart';

class MatchTipsScreen extends StatelessWidget {
  const MatchTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a237e),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1a237e),
        title: Text(
          'Daily Tips',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Add refresh functionality if needed
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Text(
                  'Expert predictions updated daily',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              _buildTipsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('daily').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (snapshot.hasError) {
          return _buildErrorState();
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        } else {
          final List<MatchTip> tips = snapshot.data!.docs
              .map((doc) => MatchTip.fromFirestore(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return _buildMatchTipCard(tips[index]);
            },
          );
        }
      },
    );
  }

  Widget _buildMatchTipCard(MatchTip tip) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip(
                  icon: Icons.sports_soccer,
                  text: tip.leagueName,
                ),
                _buildInfoChip(
                  icon: Icons.calendar_today,
                  text: tip.date,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '${tip.team1} vs ${tip.team2}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.access_time,
                  text: tip.time,
                ),
                SizedBox(width: 8.w),
                _buildInfoChip(
                  icon: Icons.tips_and_updates,
                  text: tip.tipsName,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOddsChip(tip.odds),
                _buildStatusChip(tip.status),
              ],
            ),
            if (tip.results.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _buildResultsSection(tip),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 16.sp),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOddsChip(String odds) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.trending_up,
            color: Colors.amber,
            size: 18.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            'Odds: $odds',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final Map<String, Color> statusColors = {
      'won': Colors.green,
      'lost': Colors.red,
      'pending': Colors.orange,
    };

    final Map<String, IconData> statusIcons = {
      'won': Icons.check_circle,
      'lost': Icons.cancel,
      'pending': Icons.pending,
    };

    final color = statusColors[status.toLowerCase()] ?? Colors.blue;
    final icon = statusIcons[status.toLowerCase()] ?? Icons.info;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(width: 6.w),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection(MatchTip tip) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.sports_score,
            color: Colors.green,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'Result: ${tip.results}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer,
              color: Colors.white54,
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              "No tips available",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              "Error fetching tips",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}