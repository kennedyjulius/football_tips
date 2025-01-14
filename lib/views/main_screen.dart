import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:football_tips/models/model_tips.dart';
import 'package:football_tips/services/firebase_firestore.dart';
import 'package:football_tips/views/gamecategory_screen.dart';
import 'package:football_tips/views/homescreen.dart';
import 'package:football_tips/views/match_history_screen.dart';
import 'package:football_tips/views/vipservices_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
    final TipService _tipService = TipService();
  List<Tip> _freeTips = [];
  bool _isLoading = true;
  final List<Widget> _screens = [
    const HomeScreen(freeTips: [], isLoading: false,),
    //const PremiumFeaturesScreen(),
    const GameCategoriesScreen(),
    const HistoryScreen()
  ];

  @override
  void initState() {
    super.initState();
    _fetchTips();
    _tabController = TabController(length: 3, vsync: this);
  }
   
 

     Future<void> _fetchTips() async {
    setState(() {
      _isLoading = true;
    });

    final tips = await _tipService.fetchTips();

    setState(() {
      _freeTips = tips;
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.purple.shade900],
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.diamond_rounded),
                  label: 'VIP',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_rounded),
                  label: 'History',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}