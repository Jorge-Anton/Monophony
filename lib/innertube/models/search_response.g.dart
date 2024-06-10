// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      json['contents'] == null
          ? null
          : Contents.fromJson(json['contents'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'contents': instance.contents?.toJson(),
    };

Contents _$ContentsFromJson(Map<String, dynamic> json) => Contents(
      json['tabbedSearchResultsRenderer'] == null
          ? null
          : Tabs.fromJson(
              json['tabbedSearchResultsRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentsToJson(Contents instance) => <String, dynamic>{
      'tabbedSearchResultsRenderer':
          instance.tabbedSearchResultsRenderer?.toJson(),
    };
