import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/search_suggestions_section_renderer.dart';

part 'search_suggestions_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchSuggestionsResponse {
  List<Content>? contents;

  SearchSuggestionsResponse(this.contents);

  factory SearchSuggestionsResponse.fromJson(Map<String, dynamic> json) => _$SearchSuggestionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSuggestionsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  SearchSuggestionsSectionRenderer? searchSuggestionsSectionRenderer;

  Content(this.searchSuggestionsSectionRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
