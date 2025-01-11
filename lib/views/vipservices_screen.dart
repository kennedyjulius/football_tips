

import 'package:flutter/material.dart';

class VIPServicesScreen extends StatelessWidget {
  const VIPServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Premium Services'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade800, Colors.blue.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.diamond,
                    size: 80,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),

          // Subscription Plans
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Plan',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  _buildSubscriptionCard(
                    'Monthly Premium',
                    'Perfect for serious bettors',
                    [
                      'Daily premium tips',
                      'Expert analysis',
                      'Win probability calculator',
                      'Chat support'
                    ],
                    29.99,
                    context,
                  ),
                  _buildSubscriptionCard(
                    'Quarterly Value',
                    'Most popular choice',
                    [
                      'All monthly features',
                      'Historical data analysis',
                      'Priority support',
                      'Early access to tips'
                    ],
                    69.99,
                    context,
                    isPopular: true,
                  ),
                  _buildSubscriptionCard(
                    'Annual Pro',
                    'Best value for money',
                    [
                      'All quarterly features',
                      'Personal betting consultant',
                      'Custom alerts setup',
                      'Money management tools'
                    ],
                    199.99,
                    context,
                  ),
                ],
              ),
            ),
          ),

          // Premium Features
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Features',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureGrid(context),
                ],
              ),
            ),
          ),

          // Testimonials
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What Our Members Say',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  _buildTestimonialsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(
    String title,
    String subtitle,
    List<String> features,
    double price,
    BuildContext context, {
    bool isPopular = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isPopular ? 8 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: isPopular
              ? Border.all(color: Colors.blue.shade400, width: 2)
              : null,
        ),
        child: Column(
          children: [
            if (isPopular)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  ...features.map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.green, size: 20),
                            const SizedBox(width: 8),
                            Expanded(child: Text(feature)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle subscription
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Subscribe Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      {'icon': Icons.analytics, 'title': 'Advanced Analytics'},
      {'icon': Icons.notification_important, 'title': 'Instant Alerts'},
      {'icon': Icons.chat, 'title': 'Expert Support'},
      {'icon': Icons.bar_chart, 'title': 'Performance Tracking'},
      {'icon': Icons.access_time, 'title': 'Early Access'},
      {'icon': Icons.security, 'title': 'Guaranteed Tips'},
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
          child: InkWell(
            onTap: () {
              // Handle feature tap
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  features[index]['icon'] as IconData,
                  size: 32,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(height: 8),
                Text(
                  features[index]['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestimonialsList() {
    return Column(
      children: [
        _buildTestimonial(
          'John D.',
          'Premium member for 6 months',
          'The expert analysis has completely changed my betting strategy. Highly recommended!',
          4.8,
        ),
        _buildTestimonial(
          'Sarah M.',
          'Annual Pro subscriber',
          'The personal betting consultant feature is worth every penny. My success rate has improved significantly.',
          5.0,
        ),
      ],
    );
  }

  Widget _buildTestimonial(
      String name, String title, String comment, double rating) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    name[0],
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        title,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(comment),
          ],
        ),
      ),
    );
  }
}