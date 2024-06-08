// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_two_row_item_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTwoRowItemRenderer _$MusicTwoRowItemRendererFromJson(
        Map<String, dynamic> json) =>
    MusicTwoRowItemRenderer(
      json['thumbnailRenderer'] == null
          ? null
          : ThumbnailRenderer.fromJson(
              json['thumbnailRenderer'] as Map<String, dynamic>),
      json['title'] == null
          ? null
          : Runs.fromJson(json['title'] as Map<String, dynamic>),
      json['subtitle'] == null
          ? null
          : Runs.fromJson(json['subtitle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MusicTwoRowItemRendererToJson(
        MusicTwoRowItemRenderer instance) =>
    <String, dynamic>{
      'thumbnailRenderer': instance.thumbnailRenderer?.toJson(),
      'title': instance.title?.toJson(),
      'subtitle': instance.subtitle?.toJson(),
    };
