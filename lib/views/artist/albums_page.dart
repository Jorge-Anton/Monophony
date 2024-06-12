import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monophony/innertube/artists/get_artist_albums.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/album/album_page.dart';
import 'package:monophony/widgets/album_tile.dart';
import 'package:monophony/widgets/my_text_field.dart';

class AlbumsPage extends ConsumerWidget {
  const AlbumsPage({
    super.key,
    required this.artistId,
    required this.artistName
  });

  final String artistId;
  final String artistName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final TextEditingController controller = TextEditingController(text: artistName);
    final AsyncValue<List<AlbumModel>?> albumResults = ref.watch(getArtistAlbumsProvider(artistId));
    return albumResults.when(
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
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: result.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
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

            return AlbumTile(
              album: result[index],
              onTap: () {
                Navigator.push(context, createRoute(AlbumPage(album: result[index])));
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