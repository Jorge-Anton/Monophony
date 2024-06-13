import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';

part 'search_suggestions_section_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchSuggestionsSectionRenderer {
  List<Content>? contents;

  SearchSuggestionsSectionRenderer(this.contents);

  factory SearchSuggestionsSectionRenderer.fromJson(Map<String, dynamic> json) => _$SearchSuggestionsSectionRendererFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSuggestionsSectionRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  SearchSuggestionRenderer? searchSuggestionRenderer;

  Content(this.searchSuggestionRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchSuggestionRenderer {
  NavigationEndpoint? navigationEndpoint;

  SearchSuggestionRenderer(this.navigationEndpoint);

  factory SearchSuggestionRenderer.fromJson(Map<String, dynamic> json) => _$SearchSuggestionRendererFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSuggestionRendererToJson(this);
}