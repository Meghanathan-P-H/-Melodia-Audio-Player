import 'package:flutter/material.dart';

class ScreenFovorite extends StatefulWidget {
  const ScreenFovorite({super.key});

  @override
  State<ScreenFovorite> createState() => _ScreenFovoriteState();
}

class _ScreenFovoriteState extends State<ScreenFovorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF7D7D7D), Color(0xED262626)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Favorite Songs',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              centerTitle: true,
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: 'Search here',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),border: InputBorder.none),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
