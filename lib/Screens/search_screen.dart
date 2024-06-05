import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

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
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Search Songs',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('asset/images/serchscreenimagebc.png'),
                    fit: BoxFit.cover,
                  )),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 1,
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Search here',
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
