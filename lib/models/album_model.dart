import 'package:monophony/innertube/models/music_two_row_item_renderer.dart';

class AlbumModel {
  final String name;
  final String year;
  final String thumbnail;

  const AlbumModel({
    required this.name,
    required this.year,
    required this.thumbnail
  });

  factory AlbumModel.fromMusicTwoRowItemRenderer(MusicTwoRowItemRenderer renderer) {
    return AlbumModel(
      name: renderer.title?.runs.firstOrNull?.text ?? '', 
      year: renderer.subtitle?.runs.lastOrNull?.text ?? '',
      thumbnail: renderer.thumbnailRenderer?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull?.size(240) ?? ''
    );
  }
}