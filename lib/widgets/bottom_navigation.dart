import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/favorite_screen.dart';
import 'package:melodia_audioplayer/Screens/main_home_screen.dart';
import 'package:melodia_audioplayer/Screens/playlist_screen.dart';
import 'package:melodia_audioplayer/Screens/search_screen.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int _selectedIndex = 0;
  final List<Widget> _screen = const[
    ScreenHome(),
    ScreenSearch(),
    ScreenFovorite(),
    ScreenPlayList(),
  ];
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _screen        ,
      ),
    );
  }
}

