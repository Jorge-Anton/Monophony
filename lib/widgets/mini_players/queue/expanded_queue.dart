import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/fab_controller.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/fabs/hide_on_scroll_fab.dart';
import 'package:monophony/widgets/mini_players/queue/close_expanded_queue.dart';
import 'package:monophony/widgets/show_song_details.dart';
import 'package:monophony/widgets/song_tile.dart';

class ExpandedQueue extends StatefulWidget {
  const ExpandedQueue({
    super.key,
    required this.controller,
    required this.height
  });

  final MiniplayerController controller;
  final double height;

  @override
  State<ExpandedQueue> createState() => _ExpandedQueueState();
}

class _ExpandedQueueState extends State<ExpandedQueue> {
  late AudioController _audioController;
  late FabController _fabController;

  @override
  void initState() {
    super.initState();
    _audioController = getIt<AudioController>();
    _fabController = FabController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 60,
                  child: Scaffold(
                    backgroundColor: ElevationOverlay.applySurfaceTint(Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.surfaceTint, 3.0),
                    body: ValueListenableBuilder(
                      valueListenable: _audioController.currentSongNotifier,
                      builder: (context, value, child) {
                        final List<SongModel> playlist = _audioController.playlistNotifier.value;

                        return NotificationListener<UserScrollNotification>(
                          onNotification: (notification) {
                            final ScrollDirection direction = notification.direction;
                            if (direction == ScrollDirection.reverse) {
                              _fabController.hideFab();
                            } else if (direction == ScrollDirection.forward) {
                              _fabController.showFab();
                            }
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: playlist.length,
                            itemBuilder: (context, index) {
                              return SongTile(
                                active: playlist[index] == _audioController.currentSongNotifier.value,
                                song: playlist[index],
                                onTap: () {
                                  _audioController.skipToItem(playlist[index]);
                                  setState(() {});
                                },
                                onLongPress: () {
                                  showSongDetails(playlist[index], fromQueue: true);
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    floatingActionButton: HideOnScrollFab(
                      showFabNotifier: _fabController.showFabNotifier, 
                      onPressed: () {
                        _audioController.shuffle();
                        setState(() {});
                      },
                      child: const Icon(Icons.shuffle_rounded)
                    ),
                  ),
                ),
                CloseExpandedQueue(widget: widget, audioController: _audioController),
              ],
            ),
          ),
          Opacity(
            opacity: widget.height > 80 ? 0 : (widget.height - 80) / (60-80),
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: IconButton.filledTonal(
                onPressed: () {},
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
                ),
                icon: const Icon(Icons.queue_music_rounded)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
