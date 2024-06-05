// class SongModel {
//   final String title;
//   final List<String> artists;
//   final String thumbnail;
//   final String duration;
//   final String id;

//   const SongModel({
//     required this.title,
//     required this.artists,
//     required this.thumbnail,
//     required this.duration,
//     required this.id
//   });

//   factory SongModel.fromSearchJson(Map<String, dynamic> json) {
//     final flexColumns = json["musicResponsiveListItemRenderer"]["flexColumns"];
//     final String title = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["text"];

//     final List<String> artists = [];
//     for (final artist in flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"]) {
//       if (artist["text"] == " • ") break;
//       artists.add(artist["text"]);   
//     }
//     // final String artist = artistsList.join(" ");

//     final String thumbnail = json["musicResponsiveListItemRenderer"]["thumbnail"]["musicThumbnailRenderer"]["thumbnail"]["thumbnails"].last["url"];

//     final String duration = flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"].last["text"];

//     final String id = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["navigationEndpoint"]["watchEndpoint"]["videoId"];

//     return SongModel(title: title, artists: artists, thumbnail: thumbnail, duration: duration, id: id);
//   }

//   factory SongModel.fromNextJson(Map<String, dynamic> json) {
//     final String title = json["playlistPanelVideoRenderer"]["title"]["runs"][0]["text"];

//     final List<String> artists = [];
//     for (final artist in json["playlistPanelVideoRenderer"]["longBylineText"]["runs"]) {
//       if (artist["text"] == " • ") break;
//       artists.add(artist["text"]);
//     }
//     // final String artist = artistsList.join(" ");

//     final String thumbnail = json["playlistPanelVideoRenderer"]["thumbnail"]["thumbnails"][0]["url"];

//     final String duration = json["playlistPanelVideoRenderer"]["lengthText"]["runs"][0]["text"];

//     final String id = json["playlistPanelVideoRenderer"]["navigationEndpoint"]["watchEndpoint"]["videoId"];

//     return SongModel(title: title, artists: artists, thumbnail: thumbnail, duration: duration, id: id);
//   }
// }

import 'package:audio_service/audio_service.dart';
import 'package:monophony/utils/parse_duration.dart';

class SongModel extends MediaItem {
  final List<String> artistsList;

  const SongModel({
    required super.title,
    required super.id,
    super.artUri,
    super.album,
    super.duration,
    super.artist,
    super.extras,
    this.artistsList = const []
  });

  factory SongModel.fromSearchJson(Map<String, dynamic> json) {
    final flexColumns = json["musicResponsiveListItemRenderer"]["flexColumns"];
    final String title = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["text"];

    final List<String> artist = [];
    for (final i in flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"]) {
      if (i["text"] == " • ") break;
      artist.add(i["text"]);
    }

    final Uri artUri = Uri.parse(json["musicResponsiveListItemRenderer"]["thumbnail"]["musicThumbnailRenderer"]["thumbnail"]["thumbnails"].last["url"]);

    final Duration duration = parseDuration(flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"].last["text"]);

    final String id = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["navigationEndpoint"]["watchEndpoint"]["videoId"];

    return SongModel(
      title: title, 
      id: id, 
      artist: artist.join(''), 
      artistsList: artist.where((e) => e != ' & ' && e != ', ').toList(),
      artUri: artUri, 
      extras: {'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList()},
      duration: duration
    );
  }

  factory SongModel.fromNextJson(Map<String, dynamic> json) {
    final String title = json["playlistPanelVideoRenderer"]["title"]["runs"][0]["text"];

    final List<String> artist = [];
    for (final i in json["playlistPanelVideoRenderer"]["longBylineText"]["runs"]) {
      if (i["text"] == " • ") break;
      artist.add(i["text"]);   
    }

    final Uri artUri = Uri.parse(json["playlistPanelVideoRenderer"]["thumbnail"]["thumbnails"][0]["url"]);

    final Duration duration = parseDuration(json["playlistPanelVideoRenderer"]["lengthText"]["runs"][0]["text"]);

    final String id = json["playlistPanelVideoRenderer"]["navigationEndpoint"]["watchEndpoint"]["videoId"];

    return SongModel(
      title: title, 
      id: id, 
      artist: artist.join(''), 
      artistsList: artist.where((e) => e != ' & ' && e != ', ').toList(), 
      extras: {'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList()},
      artUri: artUri, 
      duration: duration
    );
  }

  factory SongModel.fromMediaItem(MediaItem mediaItem) {
    return SongModel(
      title: mediaItem.title, 
      id: mediaItem.id, 
      artist: mediaItem.artist, 
      artistsList: mediaItem.extras!["artistsList"],
      artUri: mediaItem.artUri, 
      duration: mediaItem.duration
    );
  }
}