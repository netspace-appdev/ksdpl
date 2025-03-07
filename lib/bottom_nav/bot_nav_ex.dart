/*
import 'package:flutter/material.dart';

import '../common/helper.dart';
import '../home/home_screen.dart';




class BottomNavBarExample extends StatefulWidget {
  @override
  State<BottomNavBarExample> createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0;

  // List of screens for each tab
  final List<Widget> _pages = [
    HomeScreen(),
    const Center(child: Text('Item 2')),
    const Center(child: Text('Item 3')),
    const Center(child: Text('Item 4')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Prevents item shifting
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.lightGrey,
          iconSize: 28, // Adjust icon size
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: AppText.dashboard,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label:"Item 2",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              label: "Item 3",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: "Item 4",
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:ksdpl/common/helper.dart';

import '../home/dashboard_screen.dart';
import '../home/home_screen.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    DashboardScreen(),
    const Center(child: Text('Item 2')),
    const Center(child: Text('Item 3')),
    const Center(child: Text('Item 4')),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index==0){

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomAppBar(

          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: const Color(0xFF2E3A66), // Background color
          child: Container( //ClipPath
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, "Home", 0),
                _buildNavItem(Icons.person, "Profile", 1),
                const SizedBox(width: 50), // Space for FAB
                _buildNavItem(Icons.settings, "Settings", 2),
                _buildNavItem(Icons.more_horiz, "More", 3),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFFBC02D), // Yellow color
          onPressed: () {},
          shape: const CircleBorder(),
          // child: const Icon(Icons.add, size: 30, color: Colors.white),
          child:  Image.asset(AppImage.addIcon, height: 30,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFFBC02D) : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFFFBC02D) : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/*class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from the top-left
    path.moveTo(0, 50);

    // Draw a concave curve to the top-right corner
    path.quadraticBezierTo(size.width / 2, -50, size.width, 50);

    // Continue to bottom-right
    path.lineTo(size.width, size.height);

    // Bottom-left
    path.lineTo(0, size.height);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}*/
