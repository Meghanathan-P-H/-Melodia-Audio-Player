import 'package:flutter/material.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  height: 240,
                  width: 290,
                
                  child: Image.asset(
                      'asset/images/Screenshot_2024-05-27_191754-removebg-preview (1).png',
                      fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 30.0),
                  height: 100,
                  width: 290,
                  child: Image.asset(
                    'asset/images/Screenshot_2024-05-27_192541-removebg-preview.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
