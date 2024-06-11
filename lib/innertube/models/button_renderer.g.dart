// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_renderer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonRenderer _$ButtonRendererFromJson(Map<String, dynamic> json) =>
    ButtonRenderer(
      json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ButtonRendererToJson(ButtonRenderer instance) =>
    <String, dynamic>{
      'navigationEndpoint': instance.navigationEndpoint?.toJson(),
    };
