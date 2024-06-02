import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Transform.translate(
          offset: const Offset(15, 0),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('asset/images/MelodiaLogo.png'),
            radius: 50,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_suggest_outlined,
                color: Colors.white,
                size: 45,
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF28282F),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          currentIndex: _selectIndex,
          onTap: (int index) {
            setState(() {
              _selectIndex = index;
            });
          },iconSize: 30,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded), label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.my_library_music_outlined), label: 'Playlist')
          ]),
    );
  }
}
