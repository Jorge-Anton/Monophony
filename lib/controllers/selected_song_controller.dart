import 'package:flutter/material.dart';
import 'package:monophony/models/song_model.dart';

class SelectedSongController {
  final selectedSongNotifier = ValueNotifier<SongModel?>(null);

  void setActiveSong(SongModel song) {
    selectedSongNotifier.value = song;
  }

  void clearActiveSong() {
    selectedSongNotifier.value = null;
  }

}