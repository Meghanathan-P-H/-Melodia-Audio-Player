
import 'package:flutter/material.dart';


class ScreenSearch extends StatelessWidget {
  const ScreenSearch ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration:const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF7D7D7D), Color(0xFF171717)])),
      child:const SafeArea(child: Center(child: Text('data'),)),
    );
  }
}
