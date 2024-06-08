// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailRenderer _$ThumbnailRendererFromJson(Map<String, dynamic> json) =>
    ThumbnailRenderer(
      mapper(json, 'musicThumbnailRenderer') == null
          ? null
          : MusicThumbnailRenderer.fromJson(
              mapper(json, 'musicThumbnailRenderer') as Map<String, dynamic>),
    );

Map<String, dynamic> _$ThumbnailRendererToJson(ThumbnailRenderer instance) =>
    <String, dynamic>{
      'musicThumbnailRenderer': instance.musicThumbnailRenderer?.toJson(),
    };

MusicThumbnailRenderer _$MusicThumbnailRendererFromJson(
        Map<String, dynamic> json) =>
    MusicThumbnailRenderer(
      json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MusicThumbnailRendererToJson(
        MusicThumbnailRenderer instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail?.toJson(),
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => ThumbnailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'thumbnails': instance.thumbnails?.map((e) => e.toJson()).toList(),
    };
