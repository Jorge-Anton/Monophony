import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/controllers/active_search_controller.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/controllers/selected_song_controller.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/innertube/get_songs.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/search_page.dart';
import 'package:monophony/widgets/my_text_field.dart';
import 'package:monophony/widgets/song_tile.dart';

class SongResultsPage extends ConsumerStatefulWidget {
  const SongResultsPage({super.key});

  static final ActiveSearchController activeSearchController = getIt<ActiveSearchController>();
  static final AudioController audioController = getIt<AudioController>();
  static final SelectedSongController selectedSongController = getIt<SelectedSongController>();
  static final MyMiniPlayerController miniPlayerController = getIt<MyMiniPlayerController>();
  static final TextEditingController controller = TextEditingController();

  @override
  ConsumerState<SongResultsPage> createState() => _SongResultsPageState();
}

class _SongResultsPageState extends ConsumerState<SongResultsPage> with AutomaticKeepAliveClientMixin {
@override
  Widget build(BuildContext context) {
    super.build(context);    
    SongResultsPage.controller.text = SongResultsPage.activeSearchController.activeSearchNotifier.value;
    
    final AsyncValue<List<SongModel>> songsResults = ref.watch(getSongsProvider(SongResultsPage.activeSearchController.activeSearchNotifier.value));
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return songsResults.when(
      data: (songsResults) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: songsResults.length + 1,
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
                        controller: SongResultsPage.controller,
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
              song: songsResults[index],
              onTap: () {
                if (SongResultsPage.selectedSongController.selectedSongNotifier.value != null) {
                  SongResultsPage.audioController.stop();
                  SongResultsPage.audioController.seek(Duration.zero);
                  SongResultsPage.miniPlayerController.controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
                }
                SongResultsPage.selectedSongController.setActiveSong(songsResults[index]);
                SongResultsPage.miniPlayerController.dragDownPercentageNotifier.value = 0;
                SongResultsPage.audioController.init();
              },
              onLongPress: () {
                showSongDetails(songsResults, index);
              },
            );
          },
        );
      },
      error: (error, stackTrace) => Text('Ocurrió un error: $error'),
      loading: () => const CircularProgressIndicator(),
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
                    SongResultsPage.audioController.playNext(songsResults[index]);
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
                    SongResultsPage.audioController.add(songsResults[index]);
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
  
  @override
  bool get wantKeepAlive => true;
}