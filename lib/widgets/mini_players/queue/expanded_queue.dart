import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/fab_controller.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/fabs/hide_on_scroll_fab.dart';
import 'package:monophony/widgets/mini_players/queue/close_expanded_queue.dart';
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
                                  showSongDetails(playlist[index]);
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

  Future<void> showSongDetails(SongModel song) {
    return showModalBottomSheet(
      context: getIt<GlobalKey<ScaffoldState>>().currentContext!,
      isScrollControlled: true,
      enableDrag: false,
      shape: const LinearBorder(),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12.0, bottom: 4.0),
              child: Stack(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: CachedNetworkImage(
                          imageUrl: '${song.artUri}-w120-h120',
                          height: 58.0,
                          width: 58.0,
                        ),
                      ),
                      const SizedBox(width: 12.0,),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 60.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                                ),
                              ),
                              Text(
                                song.artist ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 14
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Transform.translate(
                      offset: const Offset(0, -10),
                      child: IconButton(
                        onPressed: () {}, 
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                        ),
                        iconSize: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Transform.translate(
                      offset: const Offset(0, 10),
                      child: IconButton(
                        onPressed: () {}, 
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero)
                        ),
                        icon: const Icon(Icons.share_rounded),
                        iconSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.list_rounded),
                  title: const Text(
                    'Añadir a lista',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 12.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Transform.scale(
                    scale: 0.85,
                    child: const FaIcon(
                      FontAwesomeIcons.recordVinyl,
                    ),
                  ),
                  title: const Text(
                    'Ir al album',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  ),
                ),
                for (final artist in song.artistsList)
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.person_rounded),
                  title: Text(
                    'Más de $artist',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  ),
                ),
                if (_audioController.currentSongNotifier.value != song)
                ListTile(
                  onTap: () {
                    _audioController.remove(_audioController.playlistNotifier.value.indexOf(song));
                    Navigator.pop(context);
                    setState(() {});
                  },
                  leading: Transform.scale(
                    scale: 0.85,
                    child: const Icon(Icons.delete_outline_rounded),
                  ),
                  title: const Text(
                    'Eliminar de la cola',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
