import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:football_tips/models/model_tips.dart';

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
    'premium_history': 'Premium',
    'draws_history': 'Draws',
    'daily_history': 'Daily',
    'htft_history': 'HT/FT',
    'epl_history': 'EPL',
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
            .map((category) => _buildCategoryHistoryList(category))
            .toList(),
      ),
    );
  }

  Widget _buildCategoryHistoryList(String category) {
    if (category == 'all') {
      return _buildAllHistoryList(); // Special handling for "all"
    } else {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(category).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching data"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text("No data available for ${_categories[category]}"));
          } else {
            final categoryTips = snapshot.data!.docs.map((doc) {
              return Tip.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>); // Map Firestore data to Tip model
            }).toList();

            return ListView.builder(
              itemCount: categoryTips.length,
              itemBuilder: (context, index) {
                return _buildHistoryItem(categoryTips[index]);
              },
            );
          }
        },
      );
    }
  }

  Widget _buildAllHistoryList() {
    return FutureBuilder<List<Tip>>(
      future: _fetchAllHistoryData(), // Fetch all category data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching data"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        } else {
          final allTips = snapshot.data!;
          return ListView.builder(
            itemCount: allTips.length,
            itemBuilder: (context, index) {
              return _buildHistoryItem(allTips[index]);
            },
          );
        }
      },
    );
  }

  Future<List<Tip>> _fetchAllHistoryData() async {
    final List<String> collections = [
      'premium_history',
      'draws_history',
      'daily_history',
      'htft_history',
      'epl_history',
    ];

    List<Tip> allTips = [];
    for (String collection in collections) {
      final querySnapshot =
          await FirebaseFirestore.instance.collection(collection).get();
      final categoryTips = querySnapshot.docs
          .map((doc) => Tip.fromFirestore(doc)) // Map to Tip model
          .toList();
      allTips.addAll(categoryTips);
    }

    return allTips;
  }

  Widget _buildHistoryItem(Tip tip) {
    final bool isWin = tip.status == 'check'; // Assuming 'results' indicates win/loss

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
          '${tip.team1} vs ${tip.team2}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isWin ? Colors.green : Colors.red,
          ),
        ),
        subtitle: Text('${tip.date} • ${tip.leagueName}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow('Prediction', tip.tipsName),
                _buildDetailRow('Odds', tip.odds),
                _buildDetailRow('Result', tip.results),
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
