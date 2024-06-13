import 'package:monophony/innertube/models/navigation_endpoint.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/models/thumbnail_model.dart';
import 'package:http/http.dart' as http;

// TODO: Unify requests

class Innertube {
  static final Map<String, String> _headers = {
    'Accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'br',
    'conection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.77 Chrome/70.0.3538.77 Safari/537.36',
    'x-goog-api-key': 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
  };

  static final http.Client _httpClient = http.Client();
  static final Innertube _instance = Innertube._();

  Innertube._();

  void close() => _httpClient.close();

  factory Innertube() {
    return _instance;
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return _httpClient.get(
      url, 
      headers: headers
    );
  }


  Future<http.Response> post(Uri url, {String body = '', Map<String, String>? headers}) {
    return _httpClient.post(
      url,
      body: body, 
      headers: headers
    );
  }

  static final Uri browse = Uri.https('music.youtube.com', '/youtubei/v1/browse', {'prettyPrint': 'false'});
  static final Uri next = Uri.https('music.youtube.com', '/youtubei/v1/next', {'prettyPrint': 'false'});
  static final Uri player = Uri.https('music.youtube.com', '/youtubei/v1/player', {'prettyPrint': 'false'});
  static final Uri queue = Uri.https('music.youtube.com', '/youtubei/v1/music/get_queue', {'prettyPrint': 'false'});
  static final Uri search = Uri.https('music.youtube.com', '/youtubei/v1/search', {'prettyPrint': 'false'});
  static final Uri searchSuggestions = Uri.https('music.youtube.com', '/youtubei/v1/music/get_search_suggestions', {'prettyPrint': 'false'});

  static const String musicResponsiveListItemRendererMask = "musicResponsiveListItemRenderer(flexColumns,fixedColumns,thumbnail,navigationEndpoint)";
  static const String musicTwoRowItemRendererMask = "musicTwoRowItemRenderer(thumbnailRenderer,title,subtitle,navigationEndpoint)";
  static const String playlistPanelVideoRendererMask = "playlistPanelVideoRenderer(title,navigationEndpoint,longBylineText,shortBylineText,thumbnail,lengthText)";

  String searchSuggestionsBody({required String input}) => '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"input":"$input"}''';
  Map<String, String> mask({String value = '*'}) => {..._headers, ...{'x-goog-fieldmask': value}};
}

class SearchFilter {
  static const song = "EgWKAQIIAWoKEAkQBRAKEAMQBA%3D%3D";
  static const album = "EgWKAQIYAWoKEAkQChAFEAMQBA%3D%3D";
  static const artist = "EgWKAQIgAWoKEAkQChAFEAMQBA%3D%3D";
  static const communityPlaylist = "EgeKAQQoAEABagoQAxAEEAoQCRAF";
  static const featuredPlaylist = "EgeKAQQoADgBagwQDhAKEAMQBRAJEAQ%3D";
}


class ArtistPage {
  final String? name;
  final String? description;
  final String? sourceDescription;
  final ThumbnailModel? thumbnail;
  final List<SongModel>? songs;
  final List<AlbumModel>? albums;
  final List<AlbumModel>? singles;
  final Watch? shuffleEndpoint;
  final Watch? radioEndpoint;
  final Browse? songsEndpoint;
  final Browse? albumsEndpoint;

  ArtistPage({
    required this.name, required this.description, 
    required this.sourceDescription, required this.thumbnail, 
    required this.songs, required this.albums, 
    required this.singles, required this.shuffleEndpoint, 
    required this.radioEndpoint, required this.songsEndpoint,
    required this.albumsEndpoint
  });
}