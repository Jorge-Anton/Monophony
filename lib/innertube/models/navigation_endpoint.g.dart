// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_endpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationEndpoint _$NavigationEndpointFromJson(Map<String, dynamic> json) =>
    NavigationEndpoint(
      json['browseEndpoint'] == null
          ? null
          : Browse.fromJson(json['browseEndpoint'] as Map<String, dynamic>),
      json['searchEndpoint'] == null
          ? null
          : Search.fromJson(json['searchEndpoint'] as Map<String, dynamic>),
      json['watchEndpoint'] == null
          ? null
          : Watch.fromJson(json['watchEndpoint'] as Map<String, dynamic>),
      json['watchPlaylistEndpoint'] == null
          ? null
          : WatchPlaylist.fromJson(
              json['watchPlaylistEndpoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NavigationEndpointToJson(NavigationEndpoint instance) =>
    <String, dynamic>{
      'watchEndpoint': instance.watchEndpoint?.toJson(),
      'watchPlaylistEndpoint': instance.watchPlaylistEndpoint?.toJson(),
      'browseEndpoint': instance.browseEndpoint?.toJson(),
      'searchEndpoint': instance.searchEndpoint?.toJson(),
    };

Watch _$WatchFromJson(Map<String, dynamic> json) => Watch(
      json['playlistId'] as String?,
      json['videoId'] as String?,
    );

Map<String, dynamic> _$WatchToJson(Watch instance) => <String, dynamic>{
      'playlistId': instance.playlistId,
      'videoId': instance.videoId,
    };

WatchPlaylist _$WatchPlaylistFromJson(Map<String, dynamic> json) =>
    WatchPlaylist(
      json['params'] as String?,
      json['playlistId'] as String?,
    );

Map<String, dynamic> _$WatchPlaylistToJson(WatchPlaylist instance) =>
    <String, dynamic>{
      'params': instance.params,
      'playlistId': instance.playlistId,
    };

Browse _$BrowseFromJson(Map<String, dynamic> json) => Browse(
      json['browseId'] as String?,
      json['params'] as String?,
    );

Map<String, dynamic> _$BrowseToJson(Browse instance) => <String, dynamic>{
      'params': instance.params,
      'browseId': instance.browseId,
    };

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      json['params'] as String?,
      json['query'] as String,
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'params': instance.params,
      'query': instance.query,
    };
