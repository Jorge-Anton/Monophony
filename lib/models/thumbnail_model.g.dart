// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailModel _$ThumbnailModelFromJson(Map<String, dynamic> json) =>
    ThumbnailModel(
      json['url'] as String,
      (json['height'] as num?)?.toInt(),
      (json['width'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ThumbnailModelToJson(ThumbnailModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'height': instance.height,
      'width': instance.width,
    };
