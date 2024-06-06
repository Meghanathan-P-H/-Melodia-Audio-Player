import 'package:flutter/material.dart';

class ScreenPlayList extends StatefulWidget {
  const ScreenPlayList({super.key});

  @override
  State<ScreenPlayList> createState() => _ScreenPlayListState();
}

class _ScreenPlayListState extends State<ScreenPlayList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF7D7D7D), Color(0xED262626)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('My Playlist',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.white,size: 36,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
