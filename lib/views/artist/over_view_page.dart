import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/controllers/fab_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/innertube/artists/get_artist_info.dart';
import 'package:monophony/innertube/innertube.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/fabs/radio_fab.dart';
import 'package:monophony/widgets/my_text_field.dart';
import 'package:monophony/widgets/song_tile.dart';

class OverViewPage extends ConsumerWidget {
  const OverViewPage({
    super.key,
    required this.artistName,
    required this.artistId,
    required this.viewNotifier
  });

  final String artistName;
  final String artistId;
  final ViewNotifier viewNotifier;

  static final AudioController _audioController = getIt<AudioController>();
  static final SelectedSongNotifier _selectedSongNotifier = getIt<SelectedSongNotifier>();
  static final MyMiniPlayerController _miniPlayerController = getIt<MyMiniPlayerController>();
  static final _fabController = FabController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final TextEditingController controller = TextEditingController(text: artistName);
    final AsyncValue<ArtistPage> info = ref.watch(getArtistInfoProvider(artistId));
    return info.when(
      data: (result) {
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
                    padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
                    child: MyTextField(
                      controller: controller,
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
                            _audioController.loadShuffle(result.shuffleEndpoint);
                            getIt<MyMiniPlayerController>().dragDownPercentageNotifier.value = 0;
                            if (getIt<SelectedSongNotifier>().value != null) {
                              getIt<MyMiniPlayerController>().controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
                            }
                          }, 
                          child: const Text('Aleatorio')
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
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: result.thumbnail?.size(480) ?? '',
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
                  if (result.songs != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Canciones',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                viewNotifier.changeView(1);
                              }, 
                              child: const Text(
                                'Ver todo',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                      for (final song in result.songs!)
                      SongTile(
                        song: song, 
                        onTap: () {
                          OverViewPage._selectedSongNotifier.setActiveSong(song);
                          OverViewPage._miniPlayerController.dragDownPercentageNotifier.value = 0;
                          OverViewPage._audioController.loadPlaylist();
                          if (OverViewPage._selectedSongNotifier.value != null) {
                            OverViewPage._miniPlayerController.controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
                          }
                        }, 
                        onLongPress: () {}
                      )
                    ],
                  ),
                  if (result.albums != null)
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 18.0, bottom: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Álbumes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  viewNotifier.changeView(2);
                                }, 
                                child: const Text(
                                  'Ver todo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 35);
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: result.albums!.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: CachedNetworkImage(
                                      imageUrl: result.albums?[index].thumbnail?.size(120) ?? '',
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
                                  const Spacer(),
                                  Text(
                                    result.albums![index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    result.albums![index].year,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  if (result.singles != null)
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 22.0, bottom: 18.0),
                          child: Text(
                            'Sencillos',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 35);
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: result.singles!.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: CachedNetworkImage(
                                      imageUrl: result.singles?[index].thumbnail?.size(120) ?? '',
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
                                  const Spacer(),
                                  Text(
                                    result.singles![index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    result.singles![index].year,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  if (result.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Text(
                            result.description!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 13
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: FaIcon(
                            FontAwesomeIcons.quoteLeft,
                            size: 20.0,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: FaIcon(
                            FontAwesomeIcons.quoteRight,
                            size: 20.0,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        )
                      ]
                    ),
                  ),
                  if (result.sourceDescription != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 20.0, top: 18.0),
                    child: Text(
                      result.sourceDescription!,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.6)
                      ),
                    ),
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
            floatingActionButton: RadioFab(
              showFabNotifier: _fabController.showFabNotifier,
              onPressed: () {
                _audioController.loadShuffle(result.radioEndpoint);
                getIt<MyMiniPlayerController>().controller.animateToHeight(height: MediaQuery.of(context).size.height, duration: Durations.medium2);
                if (getIt<SelectedSongNotifier>().value != null) {
                  getIt<MyMiniPlayerController>().dragDownPercentageNotifier.value = 0;
                }
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