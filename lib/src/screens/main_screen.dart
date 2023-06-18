// main_screen.dart
import 'package:flutter/material.dart';
import 'user_search_screen.dart';
import 'edit_profile_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    UserSearch(),
    EditProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
      scaffoldBackgroundColor: Colors.grey[900],
      textTheme: ThemeData.dark().textTheme.copyWith(
        bodyText1: TextStyle(fontFamily: 'Montserrat'),
        bodyText2: TextStyle(fontFamily: 'Montserrat'),
        headline6: TextStyle(fontFamily: 'Montserrat'),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
      ),
    );

    return Theme(
      data: _darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Main Screen', style: TextStyle(fontFamily: 'Montserrat')),
          backgroundColor: Colors.grey[900],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Edit Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
