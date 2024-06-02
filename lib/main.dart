import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Melodia Audioplayer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home:const SplashScreen(),
    );
  }
}
