import 'package:audio_service/audio_service.dart';
import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/utils/parse_duration.dart';

class SongModel extends MediaItem {
  final List<String> artistsList;
  final List<String> artistsId;

  const SongModel({
    required super.title,
    required super.id,
    super.artUri,
    super.album,
    super.duration,
    super.artist,
    super.extras,
    this.artistsList = const [],
    this.artistsId = const []
  });

  factory SongModel.fromSearchJson(Map<String, dynamic> json) {
    final flexColumns = json["musicResponsiveListItemRenderer"]["flexColumns"];
    final String title = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["text"];

    final List<String> artistId = [];
    final List<String> artist = [];
    for (final i in flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"]) {
      if (i["text"] == " • ") break;
      artist.add(i["text"]);
      if (i["text"] != ' & ' && i["text"] != ', ') {
        final navigationEndpoint = i["navigationEndpoint"];
        if (navigationEndpoint != null) {
          artistId.add(navigationEndpoint["browseEndpoint"]["browseId"]);
        }
      }
    }

    final Uri artUri = Uri.parse(json["musicResponsiveListItemRenderer"]["thumbnail"]["musicThumbnailRenderer"]["thumbnail"]["thumbnails"].last["url"]);

    final Duration duration = parseDuration(flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"].last["text"]);

    final String id = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["navigationEndpoint"]["watchEndpoint"]["videoId"];

    return SongModel(
      title: title, 
      id: id, 
      artist: artist.join(''), 
      artistsList: artist.where((e) => e != ' & ' && e != ', ').toList(),
      artistsId: artistId,
      artUri: artUri, 
      extras: {
        'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList(),
        'artistsId': artistId
      },
      duration: duration
    );
  }

  factory SongModel.fromNextJson(Map<String, dynamic> json) {
    final String title = json["playlistPanelVideoRenderer"]["title"]["runs"][0]["text"];

    final List<String> artistId = [];
    final List<String> artist = [];
    for (final i in json["playlistPanelVideoRenderer"]["longBylineText"]["runs"]) {
      if (i["text"] == " • ") break;
      artist.add(i["text"]);
      if (i["text"] != ' & ' && i["text"] != ', ') {
        artistId.add(i["navigationEndpoint"]["browseEndpoint"]["browseId"]);
      }
    }

    final Uri artUri = Uri.parse(json["playlistPanelVideoRenderer"]["thumbnail"]["thumbnails"][0]["url"] + '-w120-h120');

    final Duration duration = parseDuration(json["playlistPanelVideoRenderer"]["lengthText"]["runs"][0]["text"]);

    final String id = json["playlistPanelVideoRenderer"]["navigationEndpoint"]["watchEndpoint"]["videoId"];

    return SongModel(
      title: title, 
      id: id, 
      artist: artist.join(''), 
      artistsList: artist.where((e) => e != ' & ' && e != ', ').toList(),
      artistsId: artistId, 
      extras: {
        'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList(),
        'artistsId': artistId
      },
      artUri: artUri, 
      duration: duration,
    );
  }

  factory SongModel.fromMediaItem(MediaItem mediaItem) {
    return SongModel(
      title: mediaItem.title, 
      id: mediaItem.id, 
      artist: mediaItem.artist, 
      artistsList: mediaItem.extras!["artistsList"],
      artistsId: mediaItem.extras!["artistsId"],
      artUri: mediaItem.artUri, 
      duration: mediaItem.duration
    );
  }

  factory SongModel.fromArtistJson(Map<String, dynamic> json) {
    final flexColumns = json["musicResponsiveListItemRenderer"]["flexColumns"];
    final String title = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["text"];

    final List<String> artistId = [];
    final List<String> artist = [];
    for (final i in flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"]) {
      if (i["text"] == " • ") break;
      artist.add(i["text"]);
      if (i["text"] != ' & ' && i["text"] != ', ') {
        final navigationEndpoint = i["navigationEndpoint"];
        if (navigationEndpoint != null) {
          artistId.add(navigationEndpoint["browseEndpoint"]["browseId"]);
        }
      }
    }

    final Uri artUri = Uri.parse(json["musicResponsiveListItemRenderer"]["thumbnail"]["musicThumbnailRenderer"]["thumbnail"]["thumbnails"].last["url"]);

    final String id = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["navigationEndpoint"]["watchEndpoint"]["videoId"];

    return SongModel(
      title: title, 
      id: id, 
      artist: artist.join(''), 
      artistsList: artist.where((e) => e != ' & ' && e != ', ').toList(),
      artistsId: artistId,
      artUri: artUri, 
      extras: {
        'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList(),
        'artistsId': artistId
      },
    );
  }

  factory SongModel.fromMusicResponsiveListItemRenderer(MusicResponsiveListItemRenderer renderer) {
    final List<String>? artist = renderer.flexColumns.elementAtOrNull(1)?.musicResponsiveListItemFlexColumnRenderer?.text?.runs.map((e) => e.text ?? '').toList();
    final List<String> artistsId = renderer.flexColumns.elementAtOrNull(1)?.musicResponsiveListItemFlexColumnRenderer?.text?.runs.map((e) => e.navigationEndpoint?.browseEndpoint?.browseId ?? '').toList() ?? [];
    return SongModel(
      title: renderer.flexColumns.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.runs.firstOrNull?.text ?? '', 
      id: renderer.flexColumns.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.runs.firstOrNull?.navigationEndpoint?.watchEndpoint?.videoId ?? '',
      artist: artist?.join(),
      artistsList: artist!.where((e) => e != ' & ' && e != ', ').toList(),
      artistsId: artistsId,
      artUri: Uri.parse(renderer.thumbnail?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull?.size(120) ?? ''),
      extras: {
        'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList(),
        'artistsId': artistsId
      }
    );
  }

}