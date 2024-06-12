import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/controllers/scaffold_controller.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/artist/artist_page.dart';

Future showSongDetails(SongModel song, {bool fromQueue = false}) {
  final AudioController audioController = getIt<AudioController>();
  return showModalBottomSheet(
    context: getIt<ScaffoldController>().overlayScaffoldKey.currentContext!, 
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
                        imageUrl: song.artUri.toString(),
                        height: 58.0,
                        width: 58.0,
                      ),
                    ),
                    const SizedBox(width: 12.0),
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
                                fontSize: 14.0
                              ),
                            ),
                            Text(
                              song.artist ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14.0
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(0, -10),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Unimplemented: Add to favorites')
                          )
                        );
                      }, 
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                      ),
                      iconSize: 18.0,
                    ),
                  )
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(0, 10),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Unimplemented: Share song'))
                        );
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero)
                      ),
                      icon: const Icon(Icons.share_rounded),
                      iconSize: 18.0,
                    ),
                  )
                )
              ],
            ),
          ),
          const Divider(),
          Column(
            children: [
              ListTile(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unimplemented: Start radio'))
                  );
                },
                leading: const Icon(Icons.cell_tower_rounded),
                title: const Text(
                  'Iniciar radio',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                  ),
                ),
              ),
              if (!fromQueue)
              ListTile(
                onTap: () {
                  audioController.playNext(song);
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
              if (!fromQueue)
              ListTile(
                onTap: () {
                  if (audioController.currentSongNotifier.value == null) {
                    audioController.loadThisPlaylist([song]);
                  } else {
                    audioController.enqueue([song]);
                  }
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
              if (song.album != null)
              ListTile(
                onTap: () {
                  print(song.album);
                },
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
                  final String artistId = song.artistsId[song.artistsList.indexOf(artist)];
                  Navigator.pop(context);
                  getIt<MyMiniPlayerController>().controller.animateToHeight(height: 70, duration: Durations.medium2);
                  Navigator.push(
                    getIt<ScaffoldController>().generalScaffoldKey.currentContext!, 
                    createRoute(ArtistPage(artistId: artistId, artistName: artist))
                  );
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
              if (fromQueue && audioController.currentSongNotifier.value != song)
              ListTile(
                onTap: () {
                  audioController.remove(audioController.playlistNotifier.value.indexOf(song));
                  Navigator.pop(context);
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