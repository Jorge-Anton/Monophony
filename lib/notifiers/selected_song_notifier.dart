import 'package:flutter/material.dart';
import 'package:monophony/models/song_model.dart';

class SelectedSongNotifier extends ValueNotifier<SongModel?> {
  SelectedSongNotifier() : super(null);

  void setActiveSong(SongModel song) {
    value = song;
  }

  void clearActiveSong() {
    value = null;
  }

}