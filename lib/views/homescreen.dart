import 'package:flutter/material.dart';
import 'package:football_tips/views/match_history_screen.dart';
import 'package:football_tips/views/vipservices_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Store the navigation history to maintain state
  final List<Widget> _screens = [
    const HomeTab(),
    const VIPServicesScreen(),
    const MatchHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'VIP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

// Home Tab - Contains the original home screen content
class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Custom App Bar with Gradient
        SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade800, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: FlexibleSpaceBar(
              title: Text('BetTips Pro'),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/betting2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // VIP Services Section
        SliverToBoxAdapter(
          
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VIP Services',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildVIPCard(
                        'Premium Tips',
                        'Get access to expert predictions',
                        Icons.star,
                        Colors.amber,
                      ),
                      _buildVIPCard(
                        'Pro Analysis',
                        'Detailed match statistics',
                        Icons.analytics,
                        Colors.blue,
                      ),
                      _buildVIPCard(
                        'Live Alerts',
                        'Real-time betting opportunities',
                        Icons.notifications_active,
                        Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Free Tips Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Free Tips',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildFreeTipCard(
                  'Manchester United vs Chelsea',
                  'Premier League',
                  'Over 2.5 Goals',
                  '19:45',
                  0.85,
                ),
                _buildFreeTipCard(
                  'Real Madrid vs Barcelona',
                  'La Liga',
                  'Both Teams to Score',
                  '20:00',
                  0.75,
                ),
              ],
            ),
          ),
        ),

        // Match History Section Preview
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _buildHistoryItem(
                index % 2 == 0,
                'Match ${index + 1}',
                'Competition ${index + 1}',
                DateTime.now().subtract(Duration(days: index)),
              );
            },
            childCount: 3, // Show only 3 items in preview
          ),
        ),
      ],
    );
  }

  Widget _buildVIPCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFreeTipCard(
    String match,
    String competition,
    String prediction,
    String time,
    double confidence,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(match, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(time, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 8),
            Text(competition, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(prediction),
                  ),
                ),
                const SizedBox(width: 12),
                CircularProgressIndicator(
                  value: confidence,
                  backgroundColor: Colors.grey[200],
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
    bool isWin,
    String match,
    String competition,
    DateTime date,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isWin ? Colors.green : Colors.red,
        child: Icon(
          isWin ? Icons.check : Icons.close,
          color: Colors.white,
        ),
      ),
      title: Text(match),
      subtitle: Text(competition),
      trailing: Text(
        '${date.day}/${date.month}/${date.year}',
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }
}