import 'dart:convert';

import 'package:brotli/brotli.dart';
import 'package:monophony/innertube/artists/get_artist_info.dart';
import 'package:monophony/innertube/models/browse_response.dart';
import 'package:monophony/models/album_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'get_artist_albums.g.dart';

@Riverpod(keepAlive: true)
Future<List<AlbumModel>?> getArtistAlbums(GetArtistAlbumsRef ref, String artistId) async {
  final headers = {
    'Accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'br',
    'conection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.77 Chrome/70.0.3538.77 Safari/537.36',
    'x-goog-api-key': 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
    'x-goog-fieldmask': 'contents,header'
  };

  final artistPage = await ref.watch(getArtistInfoProvider(artistId).future);

  if (artistPage.albumsEndpoint == null) return artistPage.albums;

  final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"es","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"browseId":"${artistPage.albumsEndpoint?.browseId}", "params": "${artistPage.albumsEndpoint?.params}"}''';
  
  final res = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/browse?prettyPrint=false'),
    body: body,
    headers: headers
  );

  if (res.statusCode != 200) throw Exception('Error en la solicitud');

  final String decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());

  final BrowseResponse json = BrowseResponse.fromJson(jsonDecode(decodedBr));
  
  final albumsSection = json.contents?.singleColumnBrowseResultsRenderer?.tabs?.firstOrNull?.tabRenderer?.content?.sectionListRenderer?.contents?.firstOrNull?.gridRenderer;
  return albumsSection?.items?.nonNulls.map((e) => e.musicTwoRowItemRenderer).nonNulls.map((e) => AlbumModel.fromMusicTwoRowItemRenderer(e)).toList();
}