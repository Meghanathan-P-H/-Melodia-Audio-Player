import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundTheme()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '''Welcome to Melodia, your ultimate offline audio player! Designed with a sleek and user-friendly interface, Melodia provides seamless playback of all your favorite tracks. Whether you're commuting, working out, or simply relaxing, our app ensures you have uninterrupted access to your music library without the need for an internet connection.

Melodia is packed with features that elevate your listening experience. Enjoy high-quality sound with customizable equalizer settings to match your preferences. Create and manage playlists effortlessly, allowing you to organize your music just the way you like it. With support for various audio formats, Melodia ensures that no song is left behind.

We prioritize your convenience and satisfaction, offering a smooth and reliable performance even with large music libraries. The intuitive controls and modern design make Melodia the perfect choice for music lovers. Download Melodia today and take your tunes with you, wherever you go!''',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFF282C28),
      title: const Text(
        'ABOUT US',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
