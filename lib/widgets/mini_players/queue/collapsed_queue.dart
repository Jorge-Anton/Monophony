import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/show_song_details.dart';

class CollapsedQueue extends StatelessWidget {
  const CollapsedQueue({
    super.key,
    required this.controller
  });

  final MiniplayerController controller;
  static final AudioController audioController = getIt<AudioController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: IconButton.filledTonal(
            onPressed: () {
              controller.animateToHeight(
                height: MediaQuery.of(context).size.height,
                duration: Durations.medium2,
              );
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
            ),
            icon: const Icon(Icons.queue_music_rounded)
          ),
        ),
        Positioned(
          right: 2,
          child: IconButton(
            onPressed: () => showSongDetails(audioController.currentSongNotifier.value!, fromQueue: true), 
            icon: const Icon(Icons.more_horiz_rounded),
            iconSize: 28.0,
          ),
        )
      ],
    );
  }
}