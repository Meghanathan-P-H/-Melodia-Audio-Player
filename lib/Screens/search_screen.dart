import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundTheme()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _buildAppbar(),
            _buildSearchContent()
          ],
        ),
      ),
    );
  }

//Build the Search Screen Appbar
  AppBar _buildAppbar() {
    return AppBar(
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
            );
  }

//Stacked Background Image and Search Content
  Widget _buildSearchContent() {
    return Stack(
      children: [_buildBackgraoundImage(), _buildSearchBar()],
    );
  }

//Set the background image
  Container _buildBackgraoundImage() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('asset/images/serchscreenimagebc.png'),
        fit: BoxFit.cover,
      )),
    );
  }

//Build the Search Bar
  Positioned _buildSearchBar() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 1,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
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
    );
  }
}
