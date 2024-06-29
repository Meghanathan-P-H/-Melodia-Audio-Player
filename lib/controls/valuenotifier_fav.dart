import 'package:flutter/foundation.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';

class FavoriteSongsNotifier extends ValueNotifier<List<SongMusic>> {
  FavoriteSongsNotifier(super.value);

  void updateFavorites(List<SongMusic> updatedFavorites) {
    value = updatedFavorites;
    notifyListeners();
  }
}

final favoriteSongsNotifier = FavoriteSongsNotifier([]);

class RecentlyPlayedSongsNotifier extends ValueNotifier<List<SongMusic>> {
  RecentlyPlayedSongsNotifier() : super([]);

  void updateRecentlyPlayed(List<SongMusic> songs) {
    value = songs;
    notifyListeners();
  }
}

final recentlyPlayedSongsNotifier = RecentlyPlayedSongsNotifier();