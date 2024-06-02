import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Transform.translate( offset:const Offset(15, 0),
          child:const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('asset/images/MelodiaLogo.png'),radius: 50,
          ),
        ),
        actions: [IconButton(onPressed: (){}, icon:const Icon(Icons.settings_suggest_outlined,color: Colors.white,size: 45,))],
      ),
    );
  }
}
