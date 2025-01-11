import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, String> _categories = {
    'all': 'All History',
    'premium': 'Premium',
    'draws': 'Draws',
    'daily': 'Daily',
    'htft': 'HT/FT',
    'epl': 'EPL',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betting History'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _categories.values
              .map((category) => Tab(text: category))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories.keys
            .map((category) => _buildHistoryList(category))
            .toList(),
      ),
    );
  }

  Widget _buildHistoryList(String category) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buildHistoryItem(index, category);
      },
    );
  }

  Widget _buildHistoryItem(int index, String category) {
    final bool isWin = index % 3 != 0;
    
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
          'Match #${index + 1}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isWin ? Colors.green : Colors.red,
          ),
        ),
        subtitle: Text('$category • ${DateTime.now().toString().split(' ')[0]}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow('Prediction', 'Over 2.5'),
                _buildDetailRow('Odds', '1.95'),
                _buildDetailRow('Result', isWin ? 'Won' : 'Lost'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}