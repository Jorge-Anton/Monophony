import 'dart:convert';

import 'package:brotli/brotli.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getSearchSuggestions(String query) async {
  List<String> result = [];
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
    'x-goog-fieldmask': 'contents.searchSuggestionsSectionRenderer.contents.searchSuggestionRenderer.navigationEndpoint.searchEndpoint.query'
  };

  final body = '''{"context":{"client":{"clientName":"WEB_REMIX","clientVersion":"1.20220918","platform":"DESKTOP","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D"}},"input":"$query"}''';

  final res = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/music/get_search_suggestions?prettyPrint=false'),
    body: body,
    headers: headers
  );

  if (res.statusCode == 200) {
    final decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());
    final json = jsonDecode(decodedBr);
    for (final i in json["contents"][0]["searchSuggestionsSectionRenderer"]["contents"]) {
      final suggestion = i["searchSuggestionRenderer"]["navigationEndpoint"]["searchEndpoint"]["query"];
      if (suggestion != null) {
        result.add(suggestion);
      }
    }
    return result;
  } else {
    throw Exception('Network error');
  }
}