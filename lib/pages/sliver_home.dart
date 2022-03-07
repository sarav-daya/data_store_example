import 'package:data_store_example/pages/history_page.dart';
// import 'package:data_store_example/pages/settings_page.dart';
import 'package:data_store_example/pages/sliver_background.dart';
import 'package:flutter/material.dart';

class SliverHomePage extends StatefulWidget {
  const SliverHomePage({Key? key}) : super(key: key);

  @override
  State<SliverHomePage> createState() => _SliverHomePageState();
}

class _SliverHomePageState extends State<SliverHomePage> {
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const SliverBackgroundPage(),
        Scaffold(),
        HistoryPage()
      ][_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo.shade400,
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: _currentPageIndex,
        onTap: (index) => setState(() {
          _currentPageIndex = index;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
