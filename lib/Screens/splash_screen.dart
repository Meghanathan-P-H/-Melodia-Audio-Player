import 'dart:async';

import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/main_home_screen.dart';
// import 'package:melodia_audioplayer/home_music.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ScreenHome())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            heightFactor: 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  height: 240,
                  width: 290,
                  child: Image.asset('asset/images/MelodiaLogo.png',
                      fit: BoxFit.cover),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  height: 100,
                  width: 290,
                  child: Image.asset(
                    'asset/images/MelodiafontLogo.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
