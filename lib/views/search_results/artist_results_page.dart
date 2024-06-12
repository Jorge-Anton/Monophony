import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/innertube/artists/get_artists.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/artist/artist_page.dart';
import 'package:monophony/views/search/search_page.dart';
import 'package:monophony/widgets/artist_tile.dart';
import 'package:monophony/widgets/my_text_field.dart';

class ArtistResultsPage extends ConsumerStatefulWidget {
  const ArtistResultsPage({super.key});

  static final ActiveSearchNotifier _activeSearchNotifier = getIt<ActiveSearchNotifier>();

  @override
  ConsumerState<ArtistResultsPage> createState() => _ArtistResultsPageState();
}

class _ArtistResultsPageState extends ConsumerState<ArtistResultsPage> {
  final TextEditingController _controller = TextEditingController(text: ArtistResultsPage._activeSearchNotifier.value);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final AsyncValue<List<ArtistModel>?> artistsResults = ref.watch(getArtistsProvider(ArtistResultsPage._activeSearchNotifier.value));
    return artistsResults.when(
      data: (result) {
        if (result == null) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
                child: MyTextField(
                  controller: _controller,
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
                  const SizedBox(height: 48.0)
                ],
              );
            }

            index -= 1;

            return ArtistTile(
              artist: result[index],
              onTap: () {
                Navigator.push(context, createRoute(ArtistPage(artistId: result[index].browseId, artistName: result[index].name,)));
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
      } ,
    );
  }
}