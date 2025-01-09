import 'package:flutter/material.dart';

class MatchHistoryScreen extends StatefulWidget {
  const MatchHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MatchHistoryScreen> createState() => _MatchHistoryScreenState();
}

class _MatchHistoryScreenState extends State<MatchHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _filters = ['All', 'Wins', 'Losses'];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betting History'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              _buildStatisticsBar(),
              _buildFilterChips(),
            ],
          ),
        ),
      ),
      body: _buildHistoryList(),
    );
  }

  Widget _buildStatisticsBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total Tips', '156', Colors.blue),
          _buildStatItem('Win Rate', '68%', Colors.green),
          _buildStatItem('ROI', '+12.5%', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: _filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filter),
              selected: _selectedFilter == filter,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedFilter = filter);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      itemCount: 20, // Replace with actual data length
      itemBuilder: (context, index) {
        return _buildHistoryItem(index);
      },
    );
  }

  Widget _buildHistoryItem(int index) {
    // Sample data - replace with actual data from your database
    final bool isWin = index % 3 != 0;
    final double odds = 1.75 + (index % 5) * 0.25;
    final double stake = 10.0;
    final double profit = isWin ? stake * (odds - 1) : -stake;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: isWin ? Colors.green : Colors.red,
          child: Icon(
            isWin ? Icons.check : Icons.close,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Manchester United vs Chelsea',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isWin ? Colors.green : Colors.red,
          ),
        ),
        subtitle: Text(
          'Premier League • ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow('Prediction', 'Over 2.5 Goals'),
                _buildDetailRow('Odds', odds.toStringAsFixed(2)),
                _buildDetailRow('Stake', '\$${stake.toStringAsFixed(2)}'),
                _buildDetailRow(
                  'Profit/Loss',
                  '${profit >= 0 ? '+' : ''}\$${profit.toStringAsFixed(2)}',
                  profit >= 0 ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 8),
                _buildMatchResult('Final Score: 2-1'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchResult(String result) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        result,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Add this method to your HomeScreen to enable navigation
  void navigateToHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MatchHistoryScreen()),
    );
  }
}