// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_panel_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistPanelRenderer _$PlaylistPanelRendererFromJson(
        Map<String, dynamic> json) =>
    PlaylistPanelRenderer(
      (json['contents'] as List<dynamic>?)
          ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['continuations'] as List<dynamic>?)
          ?.map((e) => Continuation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistPanelRendererToJson(
        PlaylistPanelRenderer instance) =>
    <String, dynamic>{
      'contents': instance.contents?.map((e) => e.toJson()).toList(),
      'continuations': instance.continuations?.map((e) => e.toJson()).toList(),
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      json['automixPreviewVideoRenderer'] == null
          ? null
          : AutomixPreviewVideoRenderer.fromJson(
              json['automixPreviewVideoRenderer'] as Map<String, dynamic>),
      json['playlistPanelVideoRenderer'] == null
          ? null
          : PlaylistPanelVideoRenderer.fromJson(
              json['playlistPanelVideoRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'playlistPanelVideoRenderer':
          instance.playlistPanelVideoRenderer?.toJson(),
      'automixPreviewVideoRenderer':
          instance.automixPreviewVideoRenderer?.toJson(),
    };
