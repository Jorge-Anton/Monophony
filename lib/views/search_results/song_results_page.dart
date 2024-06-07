import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/innertube/get_songs.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/search/search_page.dart';
import 'package:monophony/widgets/my_text_field.dart';
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
    final AsyncValue<List<SongModel>> songResults = ref.watch(getSongsProvider(SongResultsPage._activeSearchNotifier.value));
    return songResults.when(
      data: (result) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: result.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: statusBarHeight + 32.0, right: 10.0),
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
                showSongDetails(result, index);
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
              padding: EdgeInsets.only(top: statusBarHeight + 32.0, right: 10.0),
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

  Future<dynamic> showSongDetails(List<SongModel> songsResults, int index) {
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
                          imageUrl: songsResults[index].artUri.toString(),
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
                                songsResults[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                                ),
                              ),
                              Text(
                                songsResults[index].artist ?? '',
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
                  leading: const Icon(Icons.cell_tower_rounded),
                  title: const Text(
                    'Iniciar radio',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    SongResultsPage._audioController.playNext(songsResults[index]);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.skip_next_rounded),
                  title: const Text(
                    'Reproducir a continuación',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    SongResultsPage._audioController.add(songsResults[index]);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.queue_music_rounded),
                  title: const Text(
                    'Añadir a la cola',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                  ),
                ),
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
                for (final artist in songsResults[index].artistsList)
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
                )
              ],
            )
          ],
        );
      },
    );
  }
}