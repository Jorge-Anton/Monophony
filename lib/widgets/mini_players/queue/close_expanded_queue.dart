import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/audio_controller.dart';

class CloseExpandedQueue extends StatelessWidget {
  const CloseExpandedQueue({
    super.key,
    required this.controller,
    required this.audioController,
  });

  final MiniplayerController controller;
  final AudioController audioController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: IconButton.filledTonal(
            onPressed: () {
              controller.animateToHeight(
                height: 60,
                duration: Durations.medium2
              );
            }, 
            style: ButtonStyle(
              shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
            ),
            icon: const FaIcon(
              FontAwesomeIcons.chevronDown,
              size: 16,
            )
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IgnorePointer(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: ElevationOverlay.applySurfaceTint(Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.surfaceTint, 3.0)
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: audioController.playlistNotifier,
                      builder: (context, value, child) {
                        return Text(
                          '${value.length} canciones',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Material(
                  color: ElevationOverlay.applySurfaceTint(Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.surfaceTint, 3.0),
                  borderRadius: BorderRadius.circular(40.0),
                  child: ValueListenableBuilder(
                    valueListenable: audioController.repeatPlaylistButtonNotifier,
                    builder: (context, value, child) {  
                      return InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)
                        ),
                        radius: 20.0,
                        onTap: () {
                          audioController.repeatPlaylist();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          child: Stack(
                            children: [
                              const Text(
                                'Bucle      ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              AnimatedPositioned(
                                right: 0,
                                bottom: value ? 0 : -19.5,
                                duration: Durations.short3,
                                child: const Column(
                                  children: [
                                    Text(
                                      'off',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Text(
                                      'on',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}