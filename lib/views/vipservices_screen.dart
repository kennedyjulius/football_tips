// premium_features_screen.dart
import 'package:flutter/material.dart';

class PremiumFeaturesScreen extends StatelessWidget {
  const PremiumFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium Header with Parallax Effect
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Premium Features'),
              background: Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [Colors.purple.shade900, Colors.blue.shade900],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          'assets/premiumservice2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Center(
                    //   child: Icon(
                    //     Icons.diamond,
                    //     size: 80,
                    //     color: Colors.white.withOpacity(0.7),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          // Premium Plans Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Your Premium Plan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSubscriptionCard(
                    title: 'Monthly Premium',
                    price: 29.99,
                    duration: 'month',
                    features: [
                      'Daily Premium Tips',
                      'VIP Draw Selections',
                      'Match Analysis',
                      'Basic Chat Support',
                    ],
                    context: context,
                  ),
                  _buildSubscriptionCard(
                    title: 'Quarterly Value',
                    price: 69.99,
                    duration: '3 months',
                    isPopular: true,
                    features: [
                      'All Monthly Features',
                      'Priority Support',
                      'Early Access to Tips',
                      'Historical Data Analysis',
                    ],
                    context: context,
                  ),
                  _buildSubscriptionCard(
                    title: 'Annual Pro',
                    price: 199.99,
                    duration: 'year',
                    features: [
                      'All Quarterly Features',
                      'Personal Betting Consultant',
                      'Custom Alerts',
                      'Money Management Tools',
                      'Advanced Statistics',
                    ],
                    context: context,
                  ),
                ],
              ),
            ),
          ),

          // Premium Features Grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Premium Features',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeaturesGrid(),
                ],
              ),
            ),
          ),

          // Success Rates Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Success Rates',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSuccessRatesCard(),
                ],
              ),
            ),
          ),

          // Premium Benefits
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Why Choose Premium?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildBenefitItem(
                        icon: Icons.verified,
                        title: 'Verified Tips',
                        description: 'All tips are thoroughly analyzed by experts',
                      ),
                      _buildBenefitItem(
                        icon: Icons.access_time,
                        title: 'Early Access',
                        description: 'Get tips before anyone else',
                      ),
                      _buildBenefitItem(
                        icon: Icons.support_agent,
                        title: 'Premium Support',
                        description: '24/7 dedicated customer support',
                      ),
                      _buildBenefitItem(
                        icon: Icons.analytics,
                        title: 'Advanced Analytics',
                        description: 'Detailed statistics and analysis tools',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle subscription
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade800,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Subscribe Now'),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required double price,
    required String duration,
    required List<String> features,
    required BuildContext context,
    bool isPopular = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isPopular ? 8 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isPopular
            ? BorderSide(color: Colors.purple.shade800, width: 2)
            : BorderSide.none,
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.purple.shade800,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: const Text(
                'MOST POPULAR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${price.toStringAsFixed(2)}/${duration}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                ...features.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: Colors.green.shade600, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(feature)),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      {'icon': Icons.sports_soccer, 'title': 'Premium Tips'},
      {'icon': Icons.analytics, 'title': 'Expert Analysis'},
      {'icon': Icons.history, 'title': 'Historical Data'},
      {'icon': Icons.notifications_active, 'title': 'Live Alerts'},
      {'icon': Icons.support_agent, 'title': '24/7 Support'},
      {'icon': Icons.trending_up, 'title': 'Success Tracking'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                features[index]['icon'] as IconData,
                size: 32,
                color: Colors.purple.shade800,
              ),
              const SizedBox(height: 8),
              Text(
                features[index]['title'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuccessRatesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessRateItem('Premium Tips', 0.90),
            _buildSuccessRateItem('VIP Draws', 0.85),
            _buildSuccessRateItem('HT/FT Tips', 0.88),
            _buildSuccessRateItem('Over/Under', 0.87),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessRateItem(String label, double rate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(
                '${(rate * 100).toInt()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: rate,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.purple.shade800, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}