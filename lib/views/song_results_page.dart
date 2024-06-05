import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/controllers/active_search_controller.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/controllers/selected_song_controller.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/services/get_songs.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/search_page.dart';
import 'package:monophony/widgets/my_text_field.dart';
import 'package:monophony/widgets/song_tile.dart';

class SongResultsPage extends StatefulWidget {
  const SongResultsPage({super.key});


  @override
  State<SongResultsPage> createState() => _SongResultsPageState();
}

class _SongResultsPageState extends State<SongResultsPage> with AutomaticKeepAliveClientMixin {
  late TextEditingController _controller;
  late ActiveSearchController _activeSearchController;
  late SelectedSongController _selectedSongController;
  late MyMiniPlayerController _miniPlayerController;
  late AudioController _audioController;
  bool _networkError = false;
  bool _loading = true;
  List<SongModel> _songsResults = [];

  @override
  void initState() {
    super.initState();
    _activeSearchController = getIt<ActiveSearchController>();
    _selectedSongController = getIt<SelectedSongController>();
    _miniPlayerController = getIt<MyMiniPlayerController>();
    _audioController = getIt<AudioController>();
    _controller = TextEditingController();
    _controller.text = _activeSearchController.activeSearchNotifier.value;
    
    if (_activeSearchController.activeSearchNotifier.value != '') {
      fetchSongs();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fetchSongs() async {
    try {
      final result = await getSongs(_activeSearchController.activeSearchNotifier.value);
      setState(() {
        _loading = false;
        _networkError = false;
        _songsResults = result;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _networkError = true;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    if (_loading) return const CircularProgressIndicator();
    if (_networkError) return const Text('Ha ocurrido un error');
    if (_songsResults.isEmpty) return const Text('Ninguna coincidencia');
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _songsResults.length + 1,
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
          song: _songsResults[index],
          onTap: () {
            if (_selectedSongController.selectedSongNotifier.value != null) {
              _audioController.stop();
              _audioController.seek(Duration.zero);
              _miniPlayerController.controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
            }
            _selectedSongController.setActiveSong(_songsResults[index]);
            _miniPlayerController.dragDownPercentageNotifier.value = 0;
            _audioController.init();
          },
          onLongPress: () {
            showSongDetails(index);
          },
        );
      },
    );
  }

  Future<dynamic> showSongDetails(int index) {
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
                          imageUrl: _songsResults[index].thumbnail,
                          height: 58.0,
                          width: 58.0,
                        ),
                      ),
                      const SizedBox(width: 12.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _songsResults[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                            ),
                          ),
                          Text(
                            _songsResults[index].artists.join(""),
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
                          padding: MaterialStateProperty.all(EdgeInsets.zero)
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
                    _audioController.playNext(_songsResults[index]);
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
                    _audioController.add(_songsResults[index]);
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
                for (final artist in _songsResults[index].artists.where((element) => element != ' & '))
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