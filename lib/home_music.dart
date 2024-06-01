import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  final _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL Music List here'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (item.data!.isEmpty) {
              return const Center(child: Text('No Songs Found'));
            } else {
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(
                    Icons.music_note_outlined,
                  ),
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text('${item.data![index].artist}'),
                  trailing: const Icon(Icons.more_horiz),
                ),
                itemCount: item.data!.length,
              );
            }
          }),
    );
  }
}
//aslfsgsj
