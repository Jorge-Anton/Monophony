import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/notifiers/play_button_notifier.dart';
import 'package:monophony/widgets/mini_players/my_mini_player.dart';

class CollapsedPlayer extends StatelessWidget {
  const CollapsedPlayer({
    super.key,
    required this.audioController,
    required this.percentage
  });

  final AudioController audioController;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.surface, 
        Theme.of(context).colorScheme.surfaceTint,
        3.0
      ),
      child: Opacity(
        opacity: 1 - (percentage / MyMiniPlayer.miniplayerPercentageDeclaration),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 55),
                  child: ValueListenableBuilder(
                    valueListenable: audioController.currentSongNotifier, 
                    builder: (context, value, child) {
                      if (value == null) return const SizedBox.shrink();
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: CachedNetworkImage(
                              imageUrl: '${value.artUri}-w120-h120',
                              height: 58.0,
                              width: 58.0,  
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  value.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  value.artist!,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                  ),
                                )
                              ],
                            )
                          ),
                          ValueListenableBuilder(
                            valueListenable: audioController.playButtonNotifier, 
                            builder: (context, value, child) {
                              switch (value) {
                                case ButtonState.loading:
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: 32.0,
                                    height: 32.0,
                                    child: const CircularProgressIndicator()
                                  );
                                case ButtonState.paused:
                                  return IconButton(
                                    icon: const Icon(Icons.play_arrow_rounded),
                                    iconSize: 32.0,
                                    onPressed: audioController.play,
                                  );
                                case ButtonState.playing:
                                  return IconButton(
                                    icon: const Icon(Icons.pause_rounded),
                                    iconSize: 32.0,
                                    onPressed: audioController.pause,
                                  );
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next_rounded),
                            iconSize: 32.0,
                            onPressed: audioController.next,
                          )
                        ],
                      );
                    },
                  )
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              height: 2,
              child: ValueListenableBuilder(
                valueListenable: audioController.progressNotifier, 
                builder: (context, value, child) {
                  if (value.total.inSeconds == 0) return const SizedBox.shrink();
                  return LinearProgressIndicator(
                    value: value.current.inSeconds / value.total.inSeconds,
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}