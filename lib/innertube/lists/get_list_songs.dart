import 'dart:convert';

import 'package:brotli/brotli.dart';
import 'package:monophony/innertube/models/browse_response.dart';
import 'package:monophony/models/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'get_list_songs.g.dart';

@Riverpod(keepAlive: true)
Future<List<SongModel>?> getListSongs(GetListSongsRef ref, String browseId) async {
  final headers = {
    'Accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'br',
    'conection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.77 Chrome/70.0.3538.77 Safari/537.36',
    'x-goog-api-key': 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
    'x-goog-fieldmask': 'contents.singleColumnBrowseResultsRenderer.tabs.tabRenderer.content.sectionListRenderer.contents(musicPlaylistShelfRenderer(continuations,contents.musicResponsiveListItemRenderer(flexColumns,fixedColumns,thumbnail,navigationEndpoint)),musicCarouselShelfRenderer.contents.musicTwoRowItemRenderer(thumbnailRenderer,title,subtitle,navigationEndpoint)),header.musicDetailHeaderRenderer(title,subtitle,thumbnail),microformat'
  };

  final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"browseId":"$browseId"}''';

  final res = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/browse?prettyPrint=false'),
    body: body,
    headers: headers
  );

  if (res.statusCode != 200) throw Exception('Error en la soliciud');

  final String decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());
  final BrowseResponse json = BrowseResponse.fromJson(jsonDecode(decodedBr));

  return json.contents?.singleColumnBrowseResultsRenderer?.tabs?.firstOrNull?.tabRenderer?.content?.sectionListRenderer?.contents?.firstOrNull?.musicShelfRenderer?.contents?.nonNulls.map((e) => e.musicResponsiveListItemRenderer).nonNulls.map((e) => SongModel.fromMusicResponsiveListItemRenderer(e)).toList();
}