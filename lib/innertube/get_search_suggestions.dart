import 'dart:convert';
import 'package:brotli/brotli.dart';
import 'package:monophony/innertube/innertube.dart';
import 'package:monophony/innertube/models/search_suggestions_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_search_suggestions.g.dart';

@riverpod
class QueryNotifier extends _$QueryNotifier {
  @override
  String build() => '';

  void updateQuery(String query) => state = query;
}

@riverpod
Future<List<String?>> getSearchSuggestions(GetSearchSuggestionsRef ref) async {
  var didDispose = false;
  ref.onDispose(() => didDispose = true);

  final query = ref.watch(queryNotifierProvider);
  if (query == '') return [];

  await Future<void>.delayed(const Duration(milliseconds: 200));

  if (didDispose) {
    return [];
  }

  final innerTube = Innertube();

  final res = await innerTube.post(
    Innertube.searchSuggestions,
    body: innerTube.searchSuggestionsBody(input: query),
    headers: innerTube.mask(value: 'contents.searchSuggestionsSectionRenderer.contents.searchSuggestionRenderer.navigationEndpoint.searchEndpoint.query')
  );

  if (res.statusCode != 200) throw Exception('Request error');
  
  final decodedBr = brotli.decodeToString(res.bodyBytes, encoding: const Utf8Codec());
  final SearchSuggestionsResponse json = SearchSuggestionsResponse.fromJson(jsonDecode(decodedBr));

  return json.contents?.firstOrNull?.searchSuggestionsSectionRenderer?.contents?.nonNulls.map((e) => e.searchSuggestionRenderer?.navigationEndpoint?.searchEndpoint?.query).toList() ?? List.empty();
}