// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_panel_video_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistPanelVideoRenderer _$PlaylistPanelVideoRendererFromJson(
        Map<String, dynamic> json) =>
    PlaylistPanelVideoRenderer(
      json['lengthText'] == null
          ? null
          : Runs.fromJson(json['lengthText'] as Map<String, dynamic>),
      json['longBylineText'] == null
          ? null
          : Runs.fromJson(json['longBylineText'] as Map<String, dynamic>),
      json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>),
      json['shortBylineText'] == null
          ? null
          : Runs.fromJson(json['shortBylineText'] as Map<String, dynamic>),
      json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['title'] == null
          ? null
          : Runs.fromJson(json['title'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistPanelVideoRendererToJson(
        PlaylistPanelVideoRenderer instance) =>
    <String, dynamic>{
      'title': instance.title?.toJson(),
      'longBylineText': instance.longBylineText?.toJson(),
      'shortBylineText': instance.shortBylineText?.toJson(),
      'lengthText': instance.lengthText?.toJson(),
      'navigationEndpoint': instance.navigationEndpoint?.toJson(),
      'thumbnail': instance.thumbnail?.toJson(),
    };
