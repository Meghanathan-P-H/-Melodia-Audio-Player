import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';

class FavoriteSongsNotifier extends ValueNotifier<List<SongMusic>> {
  FavoriteSongsNotifier(super.value);

  void updateFavorites(List<SongMusic> favorites) {
    value = favorites;
    notifyListeners();
  }
}

final favoriteSongsNotifier = FavoriteSongsNotifier([]);
