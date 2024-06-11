import 'dart:convert';

import 'package:brotli/brotli.dart';
import 'package:monophony/innertube/innertube.dart';
import 'package:monophony/innertube/models/browse_response.dart';

// ignore: library_prefixes
import 'package:monophony/innertube/models/section_list_renderer.dart' as SectionListRenderer;
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/song_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'get_artist_info.g.dart';

@Riverpod(keepAlive: true)
Future<ArtistPage> getArtistInfo(GetArtistInfoRef ref, String artistId) async {
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

  final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"es","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"browseId":"$artistId"}''';

  final res = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/browse?prettyPrint=false'),
    body: body,
    headers: headers
  );

  if (res.statusCode != 200) throw Exception('Error en la solicitud');

  final String decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());

  final BrowseResponse json = BrowseResponse.fromJson(jsonDecode(decodedBr));


  SectionListRenderer.Content? findSectionByTitle(String text) {
    return json.contents?.singleColumnBrowseResultsRenderer?.tabs?[0].tabRenderer?.content?.sectionListRenderer?.findSectionByTitle(text);
  }

  final songsSection = findSectionByTitle("Canciones")?.musicShelfRenderer;
  final albumSection = findSectionByTitle("Álbumes")?.musicCarouselShelfRenderer;
  final singlesSection = findSectionByTitle("Sencillos")?.musicCarouselShelfRenderer;

  String? rawDescription = json.header?.musicImmersiveHeaderRenderer?.description?.text;
  String? description;
  String? sourceDescription;
  if (rawDescription != null) {
    if (rawDescription.contains('wikipedia')) {
      final parts = rawDescription.split('\n\n');
      parts.removeLast();
      description = parts.join();
      sourceDescription = rawDescription.split('\n\n').last.replaceAll(RegExp(r'\(([^\)]+)\)+'), '');
    } else {
      description = rawDescription;
    }
  }

  return ArtistPage(
    name: json.header?.musicImmersiveHeaderRenderer?.title?.text, 
    description: description,
    sourceDescription: sourceDescription,
    thumbnail: json.header?.musicImmersiveHeaderRenderer?.thumbnail?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull,
    songs: songsSection?.contents?.nonNulls.map((e) => e.musicResponsiveListItemRenderer).nonNulls.map((e) => SongModel.fromMusicResponsiveListItemRenderer(e)).toList(),
    albums: albumSection?.contents?.nonNulls.map((e) => e.musicTwoRowItemRenderer).nonNulls.map((e) => AlbumModel.fromMusicTwoRowItemRenderer(e)).toList(),
    singles: singlesSection?.contents?.nonNulls.map((e) => e.musicTwoRowItemRenderer).nonNulls.map((e) => AlbumModel.fromMusicTwoRowItemRenderer(e)).toList(),
    shuffle: {
      'songId': json.header?.musicImmersiveHeaderRenderer?.playButton?.buttonRenderer?.navigationEndpoint?.watchEndpoint?.videoId ?? '',
      'playlistId': json.header?.musicImmersiveHeaderRenderer?.playButton?.buttonRenderer?.navigationEndpoint?.watchEndpoint?.playlistId ?? '',
      'params': json.header?.musicImmersiveHeaderRenderer?.playButton?.buttonRenderer?.navigationEndpoint?.watchEndpoint?.params ?? ''
    },
    radio: {
      'songId': json.header?.musicImmersiveHeaderRenderer?.startRadioButton?.buttonRenderer?.navigationEndpoint?.watchEndpoint?.videoId ?? '',
      'playlistId': json.header?.musicImmersiveHeaderRenderer?.startRadioButton?.buttonRenderer?.navigationEndpoint?.watchEndpoint?.playlistId ?? '',
      'params': json.header?.musicImmersiveHeaderRenderer?.startRadioButton?.buttonRenderer?.navigationEndpoint?.watchEndpoint?.params ?? ''
    }
  );

}