import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:melodia_audioplayer/Screens/splash_screen.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:melodia_audioplayer/db_model/db_recentlyplay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(SongMusicAdapter().typeId)) {
    Hive.registerAdapter(SongMusicAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListmodelAdapter().typeId)) {
    Hive.registerAdapter(PlayListmodelAdapter());
  }
  if (!Hive.isAdapterRegistered(RecentlySongsModelAdapter().typeId)) {
    Hive.registerAdapter(RecentlySongsModelAdapter());
  }
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
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
