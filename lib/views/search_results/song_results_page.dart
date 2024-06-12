import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/innertube/search/get_songs.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/search/search_page.dart';
import 'package:monophony/widgets/my_text_field.dart';
import 'package:monophony/widgets/show_song_details.dart';
import 'package:monophony/widgets/song_tile.dart';

class SongResultsPage extends ConsumerStatefulWidget {
  const SongResultsPage({super.key});

  static final AudioController _audioController = getIt<AudioController>();
  static final SelectedSongNotifier _selectedSongNotifier = getIt<SelectedSongNotifier>();
  static final MyMiniPlayerController _miniPlayerController = getIt<MyMiniPlayerController>();
  static final ActiveSearchNotifier _activeSearchNotifier = getIt<ActiveSearchNotifier>();
 
  @override
  ConsumerState<SongResultsPage> createState() => _SongResultsPageState();
}

class _SongResultsPageState extends ConsumerState<SongResultsPage> {
  final TextEditingController _controller = TextEditingController(text: SongResultsPage._activeSearchNotifier.value);
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final AsyncValue<List<SongModel>?> songResults = ref.watch(getSongsProvider(SongResultsPage._activeSearchNotifier.value));
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
                    padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(createRoute(const MySearchPage()), ModalRoute.withName("/"));
                      },
                      child: MyTextField(
                        controller: _controller,
                        readOnly: true,
                        enabled: false,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48.0,)
                ],
              );
            }
        
            index -= 1;
        
            return SongTile(
              song: result[index],
              onTap: () {
                SongResultsPage._selectedSongNotifier.setActiveSong(result[index]);
                SongResultsPage._miniPlayerController.dragDownPercentageNotifier.value = 0;
                SongResultsPage._audioController.loadPlaylist();
                if (SongResultsPage._selectedSongNotifier.value != null) {
                  SongResultsPage._miniPlayerController.controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
                }
              },
              onLongPress: () {
                showSongDetails(result[index]);
              },
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
              padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(createRoute(const MySearchPage()), ModalRoute.withName("/"));
                },
                child: MyTextField(
                  controller: _controller,
                  readOnly: true,
                  enabled: false,
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        );
      }
    );
  }
}