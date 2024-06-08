// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GridRenderer _$GridRendererFromJson(Map<String, dynamic> json) => GridRenderer(
      (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GridRendererToJson(GridRenderer instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['musicTwoRowItemRenderer'] == null
          ? null
          : MusicTwoRowItemRenderer.fromJson(
              json['musicTwoRowItemRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'musicTwoRowItemRenderer': instance.musicTwoRowItemRenderer?.toJson(),
    };
