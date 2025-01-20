import 'package:flutter/material.dart';

import 'package:football_tips/models/model_tips.dart';
import 'package:football_tips/services/firebase_firestore.dart';
import 'package:football_tips/views/gamecategory_screen.dart';
import 'package:football_tips/views/homescreen.dart';
import 'package:football_tips/views/match_history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final TipService _tipService = TipService();
  List<Tip> _freeTips = [];
  bool _isLoading = true;

  // Screens for each tab
  final List<Widget> _pages = [
    HomeScreen(freeTips: [], isLoading: false),
    GameCategoriesScreen(),
    HistoryScreen(),
  ];

  // Fetch tips data from the service
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
  void initState() {
    super.initState();
    _fetchTips();
  }

  // Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.diamond_outlined),
            label: 'VIP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        backgroundColor: Colors.purple.shade900,
        selectedItemColor: Colors.white, // Color of selected item
        unselectedItemColor: Colors.grey, // Color of unselected items
        showUnselectedLabels: true, // Display labels for unselected items
        type: BottomNavigationBarType.fixed, // Fixes the tab width
      ),
    );
  }
}
