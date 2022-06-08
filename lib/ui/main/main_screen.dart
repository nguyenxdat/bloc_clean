import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_clean/ui/home/home_screen.dart';
import 'package:flutter_application_bloc_clean/ui/profile/screen/profile_screen.dart';
import 'package:flutter_application_bloc_clean/ui/settings/settings_screen.dart';

class MainScreen extends StatelessWidget {
  final PageController _controller = PageController();
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F0572),
      bottomNavigationBar: MyBottomNavigationBar(
        callBack: (index) {
          _controller.jumpToPage(index);
        },
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  final Function(int) callBack;
  const MyBottomNavigationBar({
    Key? key,
    required this.callBack,
  }) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (nextIndex) {
          if (_currentIndex == nextIndex) {
            return;
          }
          _currentIndex = nextIndex;
          widget.callBack(_currentIndex);
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]);
  }
}
