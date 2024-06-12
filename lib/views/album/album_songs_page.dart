import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/fab_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/innertube/albums/get_album_songs.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/fabs/hide_on_scroll_fab.dart';
import 'package:monophony/widgets/my_text_field.dart';
import 'package:monophony/widgets/show_song_details.dart';
import 'package:monophony/widgets/song_tile.dart';

class AlbumSongsPage extends ConsumerWidget {
  const AlbumSongsPage({
    super.key,
    required this.album
  });

  final AlbumModel album;

  static final AudioController _audioController = getIt<AudioController>();
  static final SelectedSongNotifier _selectedSongNotifier = getIt<SelectedSongNotifier>();
  static final MyMiniPlayerController _myMiniPlayerController = getIt<MyMiniPlayerController>();
  static final _fabController = FabController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final TextEditingController controller = TextEditingController(text: album.name);
    final AsyncValue<List<SongModel>?> songResults = ref.watch(getAlbumSongsProvider(album.endpoint));
    return songResults.when(
      data: (result) {
        if (result == null) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
                child: MyTextField(
                  controller: controller,
                  readOnly: true,
                  enabled: false,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Text('No se han encontrado resultados'),
              )
            ],
          ); 
        }

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
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0, left: 16.0),
                    child: MyTextField(
                      controller: controller,
                      readOnly: true,
                      enabled: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 2.0),
                    child: Row(
                      children: [
                        FilledButton.tonal(
                          style: ButtonStyle(
                            visualDensity: VisualDensity.compact,
                            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
                          ),
                          onPressed: () {
                            if (_audioController.currentSongNotifier.value == null) {
                              _audioController.loadThisPlaylist(result);
                            } else {
                              _audioController.enqueue(result);
                            }
                          }, 
                          child: const Text('Añadir a la cola')
                        ),
                        const Spacer(),
                        Transform.translate(
                          offset: const Offset(10.0, 0),
                          child: IconButton(
                            onPressed: () {}, 
                            icon: const Icon(Icons.bookmark_add_outlined),
                            iconSize: 22,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                          ),
                        ),
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon(Icons.share_rounded),
                          iconSize: 22,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 32.0, top: 18.0, bottom: 18.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: CachedNetworkImage(
                        imageUrl: album.thumbnail?.size(480) ?? '',
                        errorWidget: (context, url, error) {
                          return AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: double.infinity,
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: double.infinity,
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  for (final song in result)
                  SongTile(
                    song: song, 
                    index: result.indexOf(song) + 1,
                    onTap: () async {
                      _selectedSongNotifier.setActiveSong(song);
                      _myMiniPlayerController.dragDownPercentageNotifier.value = 0;
                      await _audioController.loadThisPlaylist(result);
                      _audioController.skipToItem(song);
                      if (_selectedSongNotifier.value != null) {
                        _myMiniPlayerController.controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
                      }
                    }, 
                    onLongPress: () {
                      showSongDetails(song);
                    }
                  ),
                  ValueListenableBuilder(
                    valueListenable: getIt<MyMiniPlayerController>().dragDownPercentageNotifier, 
                    builder: (context, value, child) {
                      return SizedBox(height: 70 - 70 * value + 20.0);
                    },
                  )
                ],
              ),
            ),
            floatingActionButton: ValueListenableBuilder(
              valueListenable: _myMiniPlayerController.dragDownPercentageNotifier,
              builder: (context, value, child) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 70 - 70 * value),
                  child: HideOnScrollFab(
                    showFabNotifier: _fabController.showFabNotifier, 
                    onPressed: () {
                      final List<SongModel> playlist = List<SongModel>.from(result);
                      playlist.shuffle();
                      _audioController.loadThisPlaylist(playlist);
                    },
                    child: const Icon(Icons.shuffle_rounded)
                  ),
                );
              },
            ),
          ),
        );
      }, 
      error: (error, stackTrace) => Text(error.toString()), 
      loading: () {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
              child: MyTextField(
                controller: controller,
                readOnly: true,
                enabled: false,
              ),
            ),
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        );
      },
    );
  }
}