
import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';

class ListItemWidget extends StatelessWidget {
  final int index;
  final SongMusic song;

  const ListItemWidget({
    super.key,
    required this.index,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ScreenMusicPlay(song: song),
    ),
  );
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: _containerDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImage(),
              const SizedBox(width: 10),
              _buildTextContent(),
              _buildFavoriteButton(),
              _buildPlayButton(context),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration get _containerDecoration => BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        border: const Border(
          bottom: BorderSide(color: Colors.white, width: 1.0),
        ),
      );

  Widget _buildImage() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('asset/images/musicimage.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.name,
            style: _titleTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            song.artist,
            style: _subtitleTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  TextStyle get _titleTextStyle => const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _subtitleTextStyle => const TextStyle(
        color: Colors.white70,
        fontSize: 16,
      );

  Widget _buildFavoriteButton() {
    return IconButton(
      onPressed: (){},
      icon:const Icon(Icons.favorite_border, color: Colors.red),
      iconSize: 35.0,
    );
  }

  Widget _buildPlayButton(BuildContext context) {
     return PopupMenuButton<String>(
    icon: const Icon(Icons.more_vert_rounded, color: Colors.green, size: 40.0),
    onSelected: (String action) {
      handleActionBotton(context, action, index, song, (fn) => fn());
    },
    itemBuilder: (BuildContext context) {
      return [
        const PopupMenuItem(
          value: 'play',
          child: Text('Play'),
        ),
        PopupMenuItem(
          value: song.islike ? 'remove_favorite' : 'add_favorite',
          child: Text(song.islike ? 'Remove from Favorites' : 'Add to Favorites'),
        ),
        const PopupMenuItem(
          value: 'shre',
          child: Text('Share'),
        ),
      ];
    },
  );
  }
}