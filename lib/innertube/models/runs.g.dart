// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Runs _$RunsFromJson(Map<String, dynamic> json) => Runs(
      (json['runs'] as List<dynamic>?)
          ?.map((e) => Run.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RunsToJson(Runs instance) => <String, dynamic>{
      'runs': instance.runs?.map((e) => e.toJson()).toList(),
    };

Run _$RunFromJson(Map<String, dynamic> json) => Run(
      json['text'] as String?,
      json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RunToJson(Run instance) => <String, dynamic>{
      'text': instance.text,
      'navigationEndpoint': instance.navigationEndpoint,
    };
