import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

import 'package:football_tips/models/matchtip_model.dart';

class MatchTipsScreen extends StatelessWidget {
  const MatchTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('daily').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No match tips available"));
          } else {
            final List<MatchTip> tips = snapshot.data!.docs
                .map((doc) => MatchTip.fromFirestore(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: tips.length,
              itemBuilder: (context, index) {
                final tip = tips[index];
                return _buildMatchTipCard(tip);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildMatchTipCard(MatchTip tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo.shade900,
                  Colors.deepPurple.shade900,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // League and Date Row
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
                      const SizedBox(height: 10),
                      
                      // Teams
                      Text(
                        '${tip.team1} vs ${tip.team2}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      // Time and Tip Row
                      Row(
                        children: [
                          _buildInfoChip(
                            icon: Icons.access_time,
                            text: tip.time,
                            backgroundColor: Colors.black26,
                          ),
                          const SizedBox(width: 2),
                          _buildInfoChip(
                            icon: Icons.tips_and_updates,
                            text: tip.tipsName,
                            backgroundColor: Colors.black26,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      
                      // Odds and Status Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.trending_up,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Odds: ${tip.odds}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildStatusChip(tip.status),
                        ],
                      ),
                      const SizedBox(height: 10),
                      
                      // Results
                      if (tip.results.isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.sports_score,
                                color: Colors.green,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Result: ${tip.results}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    Color? backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
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
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
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
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}