import 'package:audio_service/audio_service.dart';
import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/innertube/models/playlist_panel_video_renderer.dart';
import 'package:monophony/innertube/models/runs.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/utils/parse_duration.dart';

// TODO: make SongModel not depend on MediaItem so that it can hold dart objects

class SongModel extends MediaItem {
  final List<String> artistsList;
  final List<String> artistsId;
  final AlbumModel? albumModel;

  const SongModel({
    required super.title,
    required super.id,
    super.artUri,
    this.albumModel,
    super.duration,
    super.artist,
    super.extras,
    this.artistsList = const [],
    this.artistsId = const []
  });

  factory SongModel.fromMediaItem(MediaItem mediaItem) {
    return SongModel(
      title: mediaItem.title, 
      id: mediaItem.id, 
      artist: mediaItem.artist, 
      artistsList: mediaItem.extras?["artistsList"],
      artistsId: mediaItem.extras?["artistsId"],
      albumModel: AlbumModel(name: mediaItem.extras?["albumModel"]["name"], endpoint: mediaItem.extras?["albumModel"]["endpoint"]),
      artUri: mediaItem.artUri, 
      duration: mediaItem.duration,
      extras: mediaItem.extras
    );
  }

  factory SongModel.fromMusicResponsiveListItemRenderer(MusicResponsiveListItemRenderer renderer) {
    final List<String> artist = renderer.flexColumns.elementAtOrNull(1)?.musicResponsiveListItemFlexColumnRenderer?.text?.splitBySeparator() ?? [];
    final List<String> artistsId = renderer.flexColumns.elementAtOrNull(1)?.musicResponsiveListItemFlexColumnRenderer?.text?.runs?.map((e) => e.navigationEndpoint?.browseEndpoint?.browseId ?? '').toList() ?? [];
    final List<String> artistsList = artist.nonNulls.where((e) => e != ' & ' && e != ', ').toList();
    Duration? duration;
    if (renderer.flexColumns.elementAtOrNull(1)?.musicResponsiveListItemFlexColumnRenderer?.text?.text.contains(' • ') == true) {
      final String? stringDuration = renderer.flexColumns.elementAtOrNull(1)?.musicResponsiveListItemFlexColumnRenderer?.text?.runs?.lastOrNull?.text;
      if (stringDuration != null) {
        duration = parseDuration(stringDuration);
      }
    }
    if (duration == null) {
      final String? stringDuration = renderer.fixedColumns?.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.runs?.firstOrNull?.text;
      if (stringDuration != null) {
        duration = parseDuration(stringDuration);
      }
    }

    final Run? albumSection = renderer.findSectionByPageType('MUSIC_PAGE_TYPE_ALBUM');
    AlbumModel? albumModel;
    if (albumSection != null) {
      albumModel = AlbumModel(
        name: albumSection.text ?? '', 
        endpoint: albumSection.navigationEndpoint?.browseEndpoint?.browseId ?? ''
      );
    }

    return SongModel(
      title: renderer.flexColumns.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.runs?.firstOrNull?.text ?? '', 
      id: renderer.flexColumns.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.runs?.firstOrNull?.navigationEndpoint?.watchEndpoint?.videoId ?? '',
      duration: duration,
      artist: artist.join(),
      artistsList: artistsList,
      artistsId: artistsId,
      albumModel: albumModel,
      artUri: Uri.parse(renderer.thumbnail?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull?.size(120) ?? ''),
      extras: {
        'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList(),
        'artistsId': artistsId,
        'albumModel': {
          'name': albumSection?.text ?? '',
          'endpoint': albumSection?.navigationEndpoint?.browseEndpoint?.browseId ?? ''
        },
      }
    );
  }

  factory SongModel.fromPlaylistVideoRenderer(PlaylistPanelVideoRenderer renderer) {
    final List<String> artist = renderer.longBylineText?.splitBySeparator() ?? [];
    final List<String> artistsId = renderer.longBylineText?.runs?.nonNulls.map((e) => e.navigationEndpoint?.browseEndpoint?.browseId ?? '').toList() ?? [];
    final Run? albumSection = renderer.findSectionByPageType('MUSIC_PAGE_TYPE_ALBUM');
    AlbumModel? albumModel;
    if (albumSection != null) {
      albumModel = AlbumModel(
        name: albumSection.text ?? '', 
        year: '', 
        thumbnail: null, 
        endpoint: albumSection.navigationEndpoint?.browseEndpoint?.browseId ?? ''
      );
    }
    return SongModel(
      title: renderer.title?.text ?? '', 
      id: renderer.navigationEndpoint?.watchEndpoint?.videoId ?? '',
      duration: parseDuration(renderer.lengthText?.runs?.firstOrNull?.text ?? ''),
      artist: artist.join(),
      artistsList: artist.where((e) => e != ' & ' && e != ', ').toList(),
      artistsId: artistsId,
      albumModel: albumModel,
      artUri: Uri.parse(renderer.thumbnail?.thumbnails?.firstOrNull?.size(120) ?? ''),
      extras: {
        'artistsList': artist.where((e) => e != ' & ' && e != ', ').toList(),
        'artistsId': artistsId,
        'albumModel': {
          'name': albumSection?.text ?? '',
          'endpoint': albumSection?.navigationEndpoint?.browseEndpoint?.browseId ?? ''
        },
      }
    );
  }

}