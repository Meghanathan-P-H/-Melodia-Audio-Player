import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/recordedaudio_file_page.dart';


class ScreenAudioRecord extends StatefulWidget {
  const ScreenAudioRecord({super.key});

  @override
  State<ScreenAudioRecord> createState() => _ScreenMusicPlayState();
}

class _ScreenMusicPlayState extends State<ScreenAudioRecord> {
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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: const Text(
            'VOICE RECORDER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>const RecorderFilesScreen()));},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ))),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 80,
                right: 30,
                left: 30,
              ),
              child: Container(
                height: 420,
                decoration:const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/images/audiomic.png'),
                        fit: BoxFit.cover,),
                   ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
