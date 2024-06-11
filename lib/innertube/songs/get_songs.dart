import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:monophony/innertube/models/search_response.dart';
import 'package:monophony/models/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:brotli/brotli.dart';

part 'get_songs.g.dart';

@Riverpod(keepAlive: true)
Future<List<SongModel>?> getSongs(GetSongsRef ref, String query) async {
  List<SongModel> result = [];
  if (query == '') return result;

  final headers = {
    'Accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'br',
    'conection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.77 Chrome/70.0.3538.77 Safari/537.36',
    'x-goog-api-key': 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
    'x-goog-fieldmask': 'contents.tabbedSearchResultsRenderer.tabs.tabRenderer.content.sectionListRenderer.contents.musicShelfRenderer(continuations,contents.musicResponsiveListItemRenderer(flexColumns,fixedColumns,thumbnail,navigationEndpoint))'
  };

  final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"query":"$query","params":"EgWKAQIIAWoKEAkQBRAKEAMQBA%3D%3D"}''';

  final res = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/search?prettyPrint=false'),
    body: body,
    headers: headers
  );

  final String decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());

  final SearchResponse json = SearchResponse.fromJson(jsonDecode(decodedBr));

  return json.contents?.tabbedSearchResultsRenderer?.tabs?.first.tabRenderer?.content?.sectionListRenderer?.contents?.elementAtOrNull(1)?.musicShelfRenderer?.contents?.nonNulls.map((e) => e.musicResponsiveListItemRenderer).nonNulls.map((e) => SongModel.fromMusicResponsiveListItemRenderer(e)).toList();
}