// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automix_preview_video_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutomixPreviewVideoRenderer _$AutomixPreviewVideoRendererFromJson(
        Map<String, dynamic> json) =>
    AutomixPreviewVideoRenderer(
      json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutomixPreviewVideoRendererToJson(
        AutomixPreviewVideoRenderer instance) =>
    <String, dynamic>{
      'content': instance.content?.toJson(),
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      json['automixPlaylistVideoRenderer'] == null
          ? null
          : AutomixPlaylistVideoRenderer.fromJson(
              json['automixPlaylistVideoRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'automixPlaylistVideoRenderer':
          instance.automixPlaylistVideoRenderer?.toJson(),
    };

AutomixPlaylistVideoRenderer _$AutomixPlaylistVideoRendererFromJson(
        Map<String, dynamic> json) =>
    AutomixPlaylistVideoRenderer(
      json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutomixPlaylistVideoRendererToJson(
        AutomixPlaylistVideoRenderer instance) =>
    <String, dynamic>{
      'navigationEndpoint': instance.navigationEndpoint?.toJson(),
    };
