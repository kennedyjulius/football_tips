import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_tips/common/carousel_widget.dart';
import 'package:football_tips/common/custom_app_bar.dart';
import 'package:football_tips/common/custom_rowbutton.dart';
import 'package:football_tips/models/model_tips.dart';
import 'package:football_tips/utils/app_constants.dart';
import 'package:football_tips/views/gamecategory_screen.dart';
import 'package:football_tips/views/marque_banner.dart';
import 'dart:ui';

import 'package:football_tips/views/matchtip_screen.dart';

class HomeScreen extends StatefulWidget {
  // Constructor removed as we will be using StreamBuilder to fetch data.
  const HomeScreen({super.key, required List freeTips, required bool isLoading});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //   late String _currentTime;
  // late String _timeOfDayIcon;

  // @override
  // void initState() {
  //   super.initState();
  //   _updateTime();
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (mounted) {
  //       setState(() {
  //         _updateTime();
  //       });
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // void _updateTime() {
  //   final now = DateTime.now();
  //   _currentTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  //   _timeOfDayIcon = _getTimeOfDayIcon(now.hour);
  // }

  // String _getTimeOfDayIcon(int hour) {
  //   if (hour >= 0 && hour < 12) return '🌅';
  //   if (hour >= 12 && hour < 16) return '⛅';
  //   return '🌙';
  // }

  

  

  Widget _buildPremiumPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade900, Colors.deepPurple.shade900],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.diamond_rounded,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PREMIUM ACCESS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Unlock exclusive tips',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPremiumStat('95%', 'Success Rate'),
                _buildDivider(),
                _buildPremiumStat('50+', 'Tips/Month'),
                _buildDivider(),
                _buildPremiumStat('24/7', 'Support'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameCategoriesScreen(),));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Center(
              child: Row(
                children: [
                  Text(
                    'GET PREMIUM ACCESS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Icon(Icons.arrow_forward_rounded, size: 20,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MaterialScrollBehavior(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade100,
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 50,
                floating: false,
                pinned: true,
                leading: IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Add menu functionality here
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.qr_code_scanner, color: Colors.white),
                    onPressed: () {
                      // Add scanner functionality here
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Add notifications functionality here
                    },
                  ),
                  SizedBox(width: 2),
                  // Add some padding at the end
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade900,
                          Colors.purple.shade900,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0)
                                ],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.asset(
                              'assets/betting2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(
                                'free') // Stream from Firestore collection
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text("Error fetching data"));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(child: Text("No tips available"));
                          } else {
                            final List<Tip> freeTips = snapshot.data!.docs
                                .map((doc) => Tip.fromFirestore(doc
                                    as DocumentSnapshot<
                                        Map<String,
                                            dynamic>>)) // Assuming a Tip.fromFirestore constructor
                                .toList();
                            return Column(
                              children: [
                                // RowWithButton(
                                //   startText: "Free Hot Tips",
                                //   buttonText: "More ...",
                                //   onButtonPressed: () {},
                                // ),
                                // SizedBox(
                                //   height: 50,
                                //   child: CurvedOscillatingMarquee(text: "Call 0743702820")),
                                SizedBox(
                                  height: 2,
                                ),
                                CarouselWidget(tips: freeTips),
                                _buildPremiumPreview(),
                                const SizedBox(height: 6),
                                //...freeTips.skip(1).map((tip) => _buildTipCard(tip, false)),
                                RowWithButton(
                                  startText: "Daily Hot Tips",
                                  buttonText: "view ...",
                                  onButtonPressed: () {},
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  height: 230,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: MatchTipsScreen(),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}

Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white24,
    );
  }
