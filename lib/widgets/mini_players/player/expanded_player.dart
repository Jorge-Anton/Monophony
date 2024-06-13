import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/notifiers/play_button_notifier.dart';
import 'package:monophony/notifiers/progress_notifier.dart';
import 'package:monophony/widgets/mini_players/my_mini_player.dart';
import 'package:monophony/widgets/mini_players/queue/queue_mini_player.dart';

class ExpandedPlayer extends StatelessWidget {
  const ExpandedPlayer({
    super.key,
    required this.audioController,
  });

  final AudioController audioController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: ElevationOverlay.applySurfaceTint(Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.surfaceTint, 3.0),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, top: MediaQuery.of(context).size.height * MyMiniPlayer.miniplayerPercentageDeclaration + 70),
              child: ValueListenableBuilder(
                valueListenable: audioController.currentSongNotifier, 
                builder: (context, value, child) {
                  if (value == null) return const SizedBox.shrink();
                  print(value.artUri);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            useOldImageOnUrlChange: true,
                            imageUrl: value.artUri.toString().startsWith('https://i.ytimg.com') ? value.artUri.toString() : '${value.artUri}-w480-h480',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            value.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            value.artist!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary
                            ),
                          )
                        ],
                      ),
                      ValueListenableBuilder<ProgressBarState>(
                        valueListenable: audioController.progressNotifier, 
                        builder: (context, value, child) {
                          return ProgressBar(
                            progress: value.current, 
                            buffered: value.buffered,
                            total: value.total,
                            onSeek: audioController.seek,
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {}, 
                            icon: Transform.scale(
                              scale: 0.6,
                              child: Icon(
                                Icons.favorite_outline_rounded,
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                              ),
                            ),
                            iconSize: 44.0,
                          ),
                          IconButton(
                            onPressed: audioController.previous, 
                            iconSize: 44.0,
                            icon: const Icon(Icons.skip_previous_rounded)
                          ),
                          ValueListenableBuilder(
                            valueListenable: audioController.playButtonNotifier, 
                            builder: (context, value, child) {
                              if (value == ButtonState.loading) {
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  width: 44.0,
                                  height: 44.0,
                                  child: const CircularProgressIndicator()
                                );
                              }

                              return IconButton.filledTonal(
                                onPressed: () {
                                  if (value == ButtonState.paused) {
                                    audioController.play();
                                  } else {
                                    audioController.pause();
                                  }
                                },
                                style: ButtonStyle(
                                  animationDuration: Durations.medium2,
                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: value == ButtonState.paused ? BorderRadius.circular(16.0) : BorderRadius.circular(50.0)
                                    )
                                  )
                                ),
                                icon: value == ButtonState.paused ? const Icon(Icons.play_arrow_rounded) : const Icon(Icons.pause_rounded),
                                iconSize: 44.0,
                              );
                            },
                          ),
                          IconButton(
                            onPressed: audioController.next,
                            iconSize: 44.0,
                            icon: const Icon(Icons.skip_next_rounded)
                          ),
                          ValueListenableBuilder(
                            valueListenable: audioController.repeatOneButtonNotifier,
                            builder: (context, value, child) {  
                              return IconButton(
                                onPressed: audioController.repeatOne, 
                                icon: Transform.scale(
                                  scale: 0.6,
                                  child: value ? 
                                    const Icon(Icons.repeat_rounded) :
                                    Icon(
                                      Icons.repeat_rounded,
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                                    ),
                                ),
                                iconSize: 44.0,
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 70.0)
                    ],
                  );
                },
              )
            ),
            const QueueMiniPlayer()
          ],
        ),
      ),
    );
  }
}
