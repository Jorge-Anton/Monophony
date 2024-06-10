// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_queue_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicQueueRenderer _$MusicQueueRendererFromJson(Map<String, dynamic> json) =>
    MusicQueueRenderer(
      json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MusicQueueRendererToJson(MusicQueueRenderer instance) =>
    <String, dynamic>{
      'content': instance.content?.toJson(),
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      mapper(json, 'playlistPanelRenderer') == null
          ? null
          : PlaylistPanelRenderer.fromJson(
              mapper(json, 'playlistPanelRenderer') as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'playlistPanelRenderer': instance.playlistPanelRenderer?.toJson(),
    };
