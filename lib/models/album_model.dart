import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/innertube/models/music_two_row_item_renderer.dart';
import 'package:monophony/models/thumbnail_model.dart';

class AlbumModel {
  final String name;
  final String year;
  final ThumbnailModel? thumbnail;
  final String? artist;
  final String endpoint;

  const AlbumModel({
    required this.name,
    this.artist,
    required this.year,
    required this.thumbnail,
    required this.endpoint
  });

  factory AlbumModel.fromMusicTwoRowItemRenderer(MusicTwoRowItemRenderer renderer) {
    return AlbumModel(
      name: renderer.title?.runs.firstOrNull?.text ?? '', 
      year: renderer.subtitle?.runs.lastOrNull?.text ?? '',
      thumbnail: renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull,
      endpoint: renderer.title?.runs.firstOrNull?.navigationEndpoint?.browseEndpoint?.browseId ?? ''
    );
  }

  factory AlbumModel.fromMusicResponsiveListItemRenderer(MusicResponsiveListItemRenderer renderer) {
    return AlbumModel(
      name: renderer.flexColumns.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.text ?? '',
      artist: renderer.flexColumns.lastOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.text.split(' • ').elementAtOrNull(1),
      year: renderer.flexColumns.lastOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.text.split(' • ').lastOrNull ?? '',
      thumbnail: renderer.thumbnail?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull,
      endpoint: renderer.navigationEndpoint?.browseEndpoint?.browseId ?? ''
    );
  }
}