import 'package:flutter/material.dart';
 


class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center( child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [],),)

      ),
    );
  }
}