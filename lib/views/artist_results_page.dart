import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/controllers/active_search_controller.dart';
import 'package:monophony/models/artist_model.dart';
import 'package:monophony/services/get_artists.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/widgets/my_text_field.dart';

class ArtistResultsPage extends StatefulWidget {
  const ArtistResultsPage({super.key});

  @override
  State<ArtistResultsPage> createState() => _ArtistResultsPageState();
}

class _ArtistResultsPageState extends State<ArtistResultsPage> with AutomaticKeepAliveClientMixin {
  late TextEditingController _controller;
  late ActiveSearchController _activeSearchController;
  bool _networkError = false;
  bool _loading = true;
  List<ArtistModel> _artistsResults = [];

  @override
  void initState() {
    super.initState();
    _activeSearchController = getIt<ActiveSearchController>();
    _controller = TextEditingController();
    _controller.text = _activeSearchController.activeSearchNotifier.value;

    fetchArtists();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fetchArtists() async {
    try {
      final result = await getArtists(_activeSearchController.activeSearchNotifier.value);
      setState(() {
        _loading = false;
        _networkError = false;
        _artistsResults = result;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _networkError = true;
        });
      }
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
    if (_artistsResults.isEmpty) return const Text('Ninguna coincidencia'); 
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _artistsResults.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: statusBarHeight + 32.0, right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    _activeSearchController.setActiveSearch(_controller.text);
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

        return ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            imageUrl: _artistsResults[index].thumbnail
          ),
        );
      },
    );
  }
}