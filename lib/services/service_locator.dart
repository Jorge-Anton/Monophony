import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:monophony/controllers/active_search_controller.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/dominant_color_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:audio_service/audio_service.dart';
import 'package:monophony/controllers/scaffold_controller.dart';
import 'package:monophony/controllers/selected_song_controller.dart';
import 'audio_handler.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<ActiveSearchController>(() => ActiveSearchController());
  getIt.registerLazySingleton<MyMiniPlayerController>(() => MyMiniPlayerController());
  getIt.registerLazySingleton<SelectedSongController>(() => SelectedSongController());
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<AudioController>(() => AudioController());
  getIt.registerLazySingleton<GlobalKey<ScaffoldState>>(() => scaffoldKey);
  getIt.registerLazySingleton<DominantColorController>(() => DominantColorController());
}