import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/notifiers/dominant_color_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/mini_players/player/collapsed_player.dart';
import 'package:monophony/widgets/mini_players/player/expanded_player.dart';

class MyMiniPlayer extends StatefulWidget {
  const MyMiniPlayer({super.key});

  static const miniplayerPercentageDeclaration = 0.05;

  @override
  State<MyMiniPlayer> createState() => _MyMiniPlayerState();
}

class _MyMiniPlayerState extends State<MyMiniPlayer> {

  late MyMiniPlayerController myMiniplayerController;
  late AudioController audioController;
  late SelectedSongNotifier selectedSongNotifier;
  bool shouldExpand = true;

  @override
  void initState() {
    super.initState();
    myMiniplayerController = getIt<MyMiniPlayerController>();
    audioController = getIt<AudioController>();
    selectedSongNotifier = getIt<SelectedSongNotifier>();
  }

  @override
  void dispose() {
    myMiniplayerController.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedSongNotifier,
      builder: (context, value, child) {
        if (value == null) return const SizedBox.shrink();
        return Miniplayer(
          onDismiss: () {
            audioController.stop();
            audioController.seek(Duration.zero);
            selectedSongNotifier.clearActiveSong();
            shouldExpand = true;
          },
          controller: myMiniplayerController.controller,
          dragDownPercentage: myMiniplayerController.dragDownPercentageNotifier,
          tapToCollapse: false,
          curve: Curves.ease,
          duration: Durations.medium2,
          minHeight: 70, 
          maxHeight: MediaQuery.of(context).size.height, 
          builder: (height, percentage) {
            if (shouldExpand) {
              myMiniplayerController.controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
              shouldExpand = false;
            }
            if (percentage < MyMiniPlayer.miniplayerPercentageDeclaration) {
              return CollapsedPlayer(audioController: audioController, percentage: percentage,);
            } else {
              return ExpandedPlayer(audioController: audioController);
            }
          },
        );
      },
    );
  }
}
