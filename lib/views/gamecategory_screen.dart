import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:football_tips/common/tipcard_widget.dart';
import 'package:football_tips/models/model_tips.dart';

class GameCategoriesScreen extends StatefulWidget {
  const GameCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<GameCategoriesScreen> createState() => _GameCategoriesScreenState();
}

class _GameCategoriesScreenState extends State<GameCategoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Draw', 'icon': Icons.draw, 'color': Colors.purple, 'collection': 'draw'},
    {'name': 'VIP Draws', 'icon': Icons.stars, 'color': Colors.amber, 'collection': 'vip_draws'},
    {'name': 'EPL', 'icon': Icons.sports_soccer, 'color': Colors.green, 'collection': 'epl'},
    {'name': 'GG', 'icon': Icons.sports, 'color': Colors.orange, 'collection': 'gg'},
    {'name': 'HTFT', 'icon': Icons.timer, 'color': Colors.red, 'collection': 'htft'},
    {'name': 'Over', 'icon': Icons.arrow_upward, 'color': Colors.teal, 'collection': 'over'},
    {'name': 'Premium', 'icon': Icons.star, 'color': Colors.blue, 'collection': 'premium'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getGamesStream(String collectionName) {
    return _firestore
        .collection(collectionName)
        .orderBy('date', descending: true)
        .snapshots();
  }

  //print(doc.data()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 50.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'VIP Game Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [const Color.fromARGB(255, 139, 166, 206), Colors.blue.shade500],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: categories
                        .map((category) => Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(category['icon']),
                                  SizedBox(width: 8),
                                  Text(category['name']),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: categories.map((category) {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _getGamesStream(category['collection']),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data?.docs ?? [];
                  final tips = docs.map((doc) => Tip.fromFirestore(doc)).toList();
                  //print(doc.data());
                  print(tips);

                  if (tips.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sports_soccer, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No tips available',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(16),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index >= tips.length) return null;
                              return TipCard(
                                tip: tips[index],
                                categoryColor: category['color'],
                              );
                            },
                            childCount: tips.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
      // floatingActionButton: _tabController.index == categories.indexWhere((cat) => cat['collection'] == 'premium' || cat['collection'] == 'vip_draws')
      //     ? FloatingActionButton.extended(
      //         onPressed: () {
      //           // Handle premium subscription
      //         },
      //         label: Text('Subscribe'),
      //         icon: Icon(Icons.star),
      //         backgroundColor: Colors.amber,
      //       )
      //     : null,
    );
  }
}



class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue.shade900,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}