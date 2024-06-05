import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:monophony/controllers/audio_controller.dart';
import 'package:monophony/services/service_locator.dart';

class CollapsedQueue extends StatelessWidget {
  const CollapsedQueue({
    super.key,
    required this.controller
  });

  final MiniplayerController controller;
  static final AudioController audioController = getIt<AudioController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: IconButton.filledTonal(
            onPressed: () {
              controller.animateToHeight(
                height: MediaQuery.of(context).size.height,
                duration: Durations.medium2,
              );
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
            ),
            icon: const Icon(Icons.queue_music_rounded)
          ),
        ),
        Positioned(
          right: 2,
          child: IconButton(
            onPressed: () => showSongDetails(), 
            icon: const Icon(Icons.more_horiz_rounded),
            iconSize: 28.0,
          ),
        )
      ],
    );
  }

  Future<void> showSongDetails() {
    final song = audioController.currentSongNotifier.value;
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
                          imageUrl: '${song!.artUri}-w120-h120',
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
                )
              ],
            )
          ],
        );
      },
    );
  }
}