import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/models/thumbnail_model.dart';

class ArtistPage {
  final String? name;
  final String? description;
  final String? sourceDescription;
  final ThumbnailModel? thumbnail;
  final List<SongModel>? songs;
  final List<AlbumModel>? albums;
  final List<AlbumModel>? singles;
  final Map<String, String> shuffle;
  final Map<String, String> radio;

  ArtistPage({required this.name, required this.description, required this.sourceDescription, required this.thumbnail, required this.songs, required this.albums, required this.singles, required this.shuffle, required this.radio});
}