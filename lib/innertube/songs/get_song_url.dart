import 'dart:convert';

import 'package:brotli/brotli.dart';
import 'package:http/http.dart' as http;

Future<String> getSongUrl(String id) async {
  final headers = {
    'Accept': 'application/json',
    'accept-charset': 'UTF-8',
    'accept-encoding': 'br',
    'conection': 'Keep-Alive',
    'content-type': 'application/json',
    'host': 'music.youtube.com',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/70.0.3538.77 Chrome/70.0.3538.77 Safari/537.36',
    'x-goog-api-key': 'AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8',
    'x-goog-fieldmask': 'playabilityStatus.status,playerConfig.audioConfig,streamingData.adaptiveFormats,videoDetails.videoId'
  };

  final body = '''{"context":{"client":{"clientName":"ANDROID_MUSIC","clientVersion":"5.28.1","platform":"MOBILE","hl":"en","visitorData":"CgtEUlRINDFjdm1YayjX1pSaBg%3D%3D","androidSdkVersion":30,"userAgent":"com.google.android.apps.youtube.music/5.28.1 (Linux; U; Android 11) gzip"}},"videoId":"$id"}''';

  final res = await http.post(
    Uri.parse('https://music.youtube.com/youtubei/v1/player?prettyPrint=false'),
    body: body,
    headers: headers
  );

  if (res.statusCode == 200) {
    final decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());
    final rawJson = jsonDecode(decodedBr);
    final List parsedJson = rawJson["streamingData"]["adaptiveFormats"];
    final streamingData = parsedJson.lastWhere((element) => element["itag"] == 140);
    return streamingData["url"];
  } else {
    throw Exception('Network Error');
  }
}