import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/main_home_screen.dart';
import 'package:melodia_audioplayer/Screens/playlist_screen.dart';
import 'package:melodia_audioplayer/Screens/search_screen.dart';
import 'package:melodia_audioplayer/screens/favorite_screen.dart';


class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  int _selectedIndex = 0;

//List of screens corresponding to each item in bottom navigation
  final List<Widget> _screens = const[
    ScreenHome(),
    ScreenSearch(),
    ScreenFovorite(),
    ScreenPlayList(),
  ];

//List of screens corresponding to each item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF28282F),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music_outlined),
            label: 'Playlist',
          ),
        ],
      ),
// // Display the currently selected screen      
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens        ,
      ),
    );
  }
}

