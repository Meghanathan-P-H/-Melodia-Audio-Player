import 'dart:async';

import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/widgets/bottom_navigation.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }
// Function handle the Intialization
  Future<void> _initialize() async {
    await _requestPermission();
    _navigateToHome();
  }
// Function to navigate to the home screen
  Future<void> _requestPermission() async {
    await Permission.storage.request();
  }
// Function to navigate to the home screen
  void _navigateToHome() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainHome())));
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
              children: <Widget>[_buildLogo(), _buildFontLogo()],
            ),
          )),
    );
  }

//Build the Main Logo
  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      height: 240,
      width: 290,
      child: Image.asset('asset/images/MelodiaLogo.png', fit: BoxFit.cover),
    );
  }

//Build the Font Logo
  Widget _buildFontLogo() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      height: 100,
      width: 290,
      child: Image.asset(
        'asset/images/MelodiafontLogo.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
