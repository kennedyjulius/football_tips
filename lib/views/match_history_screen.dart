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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery ='';
  bool _isSearching = false;

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
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  _isSearching ?  TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            //contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            hintText: "Search Matches here ...",
            hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            border: InputBorder.none,
          ),
          autofocus: true,
        ) : Text("Betting History"),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
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

  bool _filterTip(Tip tip){
    if (_searchQuery.isEmpty) return true; {
      return tip.team1.toLowerCase().contains(_searchQuery) 
      || tip.team2.toLowerCase().contains(_searchQuery)
      || tip.leagueName.toLowerCase().contains(_searchQuery)
      || tip.tipsName.toLowerCase().contains(_searchQuery);
    
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
          final allTips = snapshot.data!.where((tip) => _filterTip(tip)).toList();

          if (allTips.isEmpty && _searchQuery.isNotEmpty) {
            return const Center(child: Text("No matches found"),);
          
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
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
    final bool isWin = tip.status == 'check';
    final resultColor = isWin ? Colors.green.shade100 : Colors.red.shade100;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isWin ? Colors.green.shade200 : Colors.red.shade200,
          width: 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: resultColor,
            ),
            child: Icon(
              isWin ? Icons.check : Icons.close,
              color: isWin ? Colors.green : Colors.red,
            ),
          ),
          title: Text(
            '${tip.team1} vs ${tip.team2}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isWin ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
          subtitle: Text(
            '${tip.date} • ${tip.leagueName}',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          childrenPadding: const EdgeInsets.all(16),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildDetailRow('Prediction', tip.tipsName),
                  const Divider(height: 16),
                  _buildDetailRow('Odds', tip.odds),
                  const Divider(height: 16),
                  _buildDetailRow('Result', tip.results),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600),),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
