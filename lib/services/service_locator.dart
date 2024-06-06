import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/notifiers/dominant_color_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:audio_service/audio_service.dart';
import 'package:monophony/controllers/scaffold_controller.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'audio_handler.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<MyMiniPlayerController>(() => MyMiniPlayerController());
  getIt.registerLazySingleton<ActiveSearchNotifier>(() => ActiveSearchNotifier());
  getIt.registerLazySingleton<SelectedSongNotifier>(() => SelectedSongNotifier());
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<AudioController>(() => AudioController());
  getIt.registerLazySingleton<GlobalKey<ScaffoldState>>(() => scaffoldKey);
  getIt.registerLazySingleton<DominantColorNotifier>(() => DominantColorNotifier());
}