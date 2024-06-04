import 'package:flutter/material.dart';

class ScreenFovorite extends StatefulWidget {
  const ScreenFovorite({super.key});

  @override
  State<ScreenFovorite> createState() => _ScreenFovoriteState();
}

class _ScreenFovoriteState extends State<ScreenFovorite> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Favorite Screen'),),);
  }
}