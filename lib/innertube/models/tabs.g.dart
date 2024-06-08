// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tabs _$TabsFromJson(Map<String, dynamic> json) => Tabs(
      (json['tabs'] as List<dynamic>?)
          ?.map((e) => Tab.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TabsToJson(Tabs instance) => <String, dynamic>{
      'tabs': instance.tabs?.map((e) => e.toJson()).toList(),
    };

Tab _$TabFromJson(Map<String, dynamic> json) => Tab(
      json['tabRenderer'] == null
          ? null
          : TabRenderer.fromJson(json['tabRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TabToJson(Tab instance) => <String, dynamic>{
      'tabRenderer': instance.tabRenderer?.toJson(),
    };

TabRenderer _$TabRendererFromJson(Map<String, dynamic> json) => TabRenderer(
      json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
      json['title'] as String?,
      json['tabIdentifier'] as String?,
    );

Map<String, dynamic> _$TabRendererToJson(TabRenderer instance) =>
    <String, dynamic>{
      'content': instance.content?.toJson(),
      'title': instance.title,
      'tabIdentifier': instance.tabIdentifier,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      json['sectionListRenderer'] == null
          ? null
          : SectionListRenderer.fromJson(
              json['sectionListRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'sectionListRenderer': instance.sectionListRenderer?.toJson(),
    };
