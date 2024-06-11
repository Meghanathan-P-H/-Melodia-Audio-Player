import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:melodia_audioplayer/Screens/splash_screen.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SongMusicAdapter());
  await Hive.openBox<SongMusic>('music_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melodia Audioplayer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
