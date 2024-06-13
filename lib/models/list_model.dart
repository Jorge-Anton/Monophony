import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/models/thumbnail_model.dart';

class ListModel {
  final String name;
  final String artist;
  final ThumbnailModel? thumbnail;
  final String endpoint;

  const ListModel({
    required this.name,
    required this.artist,
    required this.thumbnail,
    required this.endpoint
  });

  factory ListModel.fromMusicResponsiveListItemRenderer(MusicResponsiveListItemRenderer renderer) {
    final name = renderer.flexColumns.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.text ?? '';
    final artist = renderer.flexColumns.elementAtOrNull(1)?.musicResponsiveListItemFlexColumnRenderer?.text?.splitBySeparator().join() ?? '';
    final thumbnail = renderer.thumbnail?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull;
    final endpoint = renderer.navigationEndpoint?.browseEndpoint?.browseId ?? '';
    return ListModel(name: name, artist: artist, thumbnail: thumbnail, endpoint: endpoint);
  }
}