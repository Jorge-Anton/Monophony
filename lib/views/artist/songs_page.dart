import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/innertube/artists/get_artist_songs.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/my_text_field.dart';
import 'package:monophony/widgets/show_song_details.dart';
import 'package:monophony/widgets/song_tile.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({
    super.key,
    required this.artistId,
    required this.artistName
  });

  final String artistId;
  final String artistName;

  static final MyMiniPlayerController _miniPlayerController = getIt<MyMiniPlayerController>();
  static final SelectedSongNotifier _selectedSongNotifier = getIt<SelectedSongNotifier>();
  static final AudioController _audioController = getIt<AudioController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final TextEditingController controller = TextEditingController(text: artistName);
    final AsyncValue<List<SongModel>?> songResults = ref.watch(getArtistSongsProvider(artistId));
    return songResults.when(
      data: (result) {
        if (result == null) return const SizedBox.shrink();
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: result.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: statusBarHeight + 32.0, right: 10.0),
                    child: MyTextField(
                      controller: controller,
                      readOnly: true,
                      enabled: false,
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                ],
              );
            }
            index -= 1;

            return SongTile(
              song: result[index], 
              onTap: () {
                _selectedSongNotifier.setActiveSong(result[index]);
                _miniPlayerController.dragDownPercentageNotifier.value = 0;
                _audioController.loadPlaylist();
                if (_selectedSongNotifier.value != null) {
                  _miniPlayerController.controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
                }
              }, 
              onLongPress: () {
                showSongDetails(result[index]);
              }
            );
          },
        );
      }, 
      error: (error, stackTrace) => Text(error.toString()), 
      loading: () {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: statusBarHeight + 32.0, right: 10.0),
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