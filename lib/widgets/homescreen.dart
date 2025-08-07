import 'package:flutter/material.dart';
import 'package:maverick_app/features/history/history_screen.dart';
import 'package:maverick_app/features/profile/profile_screen.dart';
import 'package:maverick_app/features/transaction/transaction_screen.dart';
import '../features/home/home.dart';
import 'custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  final List<Widget> screens = [
    Home(),
    TransactionScreen(),
    HistoryScreen(),
    ProfileScreen(),
    // ProfileScreen(),
  ];

  void moveToSelectedScreen(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: CustomBottomNavBar(
        onTabClicked: (index) => moveToSelectedScreen(index),
        activeTab: screenIndex,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
