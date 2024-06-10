import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/tabs.dart';

part 'search_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponse {
  Contents? contents;

  SearchResponse(this.contents);

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Contents {
  Tabs? tabbedSearchResultsRenderer;

  Contents(this.tabbedSearchResultsRenderer);

  factory Contents.fromJson(Map<String, dynamic> json) => _$ContentsFromJson(json);
  Map<String, dynamic> toJson() => _$ContentsToJson(this);
}