import 'package:flutter/material.dart';


class RecorderFilesScreen extends StatefulWidget {
  const RecorderFilesScreen({super.key});

  @override
  State<RecorderFilesScreen> createState() => _ScreenMusicPlayState();
}

class _ScreenMusicPlayState extends State<RecorderFilesScreen> {
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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor:const Color(0xFF282C28),
          title: const Text(
            'RECORDER AUDIOS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
