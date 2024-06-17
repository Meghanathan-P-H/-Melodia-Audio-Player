import 'dart:async';
import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/screens/permission_provider.dart';
import 'package:melodia_audioplayer/widgets/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SongFetcher _songFetcher = SongFetcher(); 
  @override
  void initState() {
    super.initState();
    _initialize();
  }
    Future<void> _initialize() async {
    bool permissionGranted = await _songFetcher.requestAudioPermission();
    if (permissionGranted) {
      await Future.delayed(const Duration(seconds: 3));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainHome()));
    }
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
