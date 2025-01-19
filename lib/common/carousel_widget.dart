import 'dart:ui';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
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
            height: 320,
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
        const SizedBox(height: 16),
        DotsIndicator(
          dotsCount: widget.tips.length,
          position: _currentIndex,
          decorator: DotsDecorator(
            size: const Size.square(8.0),
            activeSize: const Size(24.0, 8.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            activeColor: Colors.orange.shade400,
            color: Colors.grey.shade600,
            spacing: const EdgeInsets.all(4),
          ),
        ),
      ],
    );
  }

  Widget _buildTipCard(Tip tip, bool isHighlighted) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isHighlighted
              ? [Colors.deepOrange.shade900, Colors.red.shade900]
              : [Colors.indigo.shade900, Colors.purple.shade900],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isHighlighted
                ? Colors.orange.withOpacity(0.3)
                : Colors.purple.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Date and Hot Tip badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoChip(
                      icon: Icons.calendar_today,
                      text: tip.date,
                    ),
                    if (isHighlighted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade400,
                              Colors.orange.shade700,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.local_fire_department,
                                color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'HOT TIP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),


                // Teams and Odds Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '${tip.team1} vs ${tip.team2}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isHighlighted ? 20 : 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade400,
                            Colors.green.shade700,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.trending_up,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            tip.odds,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                      Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.sports_soccer_outlined,
                      text: tip.leagueName,
                    ),
                    const SizedBox(width: 12),
                    // Expanded(
                    //   child: _buildInfoChip(
                    //     icon: Icons.sports_soccer,
                    //     text: tip.tipsName,
                    //   ),
                    // ),

                     Expanded(
                      child: _buildInfoChip(
                        icon: Icons.sports_soccer,
                        text: tip.time,
                      ),
                    ),
                  ],
                ),
                    SizedBox(height: 10,),


                // Time and Tip Name Row
                Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.access_time,
                      text: tip.time,
                    ),
                    const SizedBox(width: 12),
                    // Expanded(
                    //   child: _buildInfoChip(
                    //     icon: Icons.sports_soccer,
                    //     text: tip.tipsName,
                    //   ),
                    // ),

                     Expanded(
                      child: _buildInfoChip(
                        icon: Icons.sports_soccer,
                        text: tip.tipsName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Status and Results Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white10,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildStatusIndicator(tip.status),
                          const SizedBox(width: 12),
                          if (tip.results.isNotEmpty) ...[
                            const Icon(
                              Icons.sports_score,
                              color: Colors.green,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tip.results,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color statusColor;
    IconData statusIcon;
    
    switch (status.toLowerCase()) {
      case 'won':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'lost':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        break;
      default:
        statusColor = Colors.blue;
        statusIcon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}