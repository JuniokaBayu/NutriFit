import 'package:fit_scale/screens/home_screen.dart';
// Import HistoryScreen
import 'package:fit_scale/screens/history_screen.dart';

import 'package:fit_scale/screens/info_screen.dart';     // Import InfoScreen
import 'package:flutter/material.dart';
import '../utility/app_color.dart';

class MainNavigator extends StatefulWidget {
  final String userName;
  const MainNavigator({super.key, required this.userName});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Inisialisasi daftar layar yang dapat diganti
    _screens = [
      // Screen 0: Home Screen (Kalkulator BMI)
      HomeScreen(userName: widget.userName),
      // Screen 1: History Screen
      const HistoryScreen(),
      // Screen 2: Info Screen
      const InfoScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body akan menampilkan layar yang dipilih
      body: _screens[_selectedIndex],
      
      // Bottom Navigation Bar
     bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColor.background(context, light: AppColor.creamLight, dark: AppColor.darkBlack),
        selectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? AppColor.creamLight // Biru muda untuk Dark Mode
            : AppColor.appBarTitle, // Biru tua untuk Light Mode
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? AppColor.lightWhite // Abu-abu terang untuk Dark Mode
            : AppColor.black38, // Hitam/abu-abu untuk Light Mode
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}