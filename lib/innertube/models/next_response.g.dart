// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextResponse _$NextResponseFromJson(Map<String, dynamic> json) => NextResponse(
      json['contents'] == null
          ? null
          : Contents.fromJson(json['contents'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NextResponseToJson(NextResponse instance) =>
    <String, dynamic>{
      'contents': instance.contents?.toJson(),
    };

Contents _$ContentsFromJson(Map<String, dynamic> json) => Contents(
      json['singleColumnMusicWatchNextResultsRenderer'] == null
          ? null
          : SingleColumnMusicWatchNextResultsRenderer.fromJson(
              json['singleColumnMusicWatchNextResultsRenderer']
                  as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentsToJson(Contents instance) => <String, dynamic>{
      'singleColumnMusicWatchNextResultsRenderer':
          instance.singleColumnMusicWatchNextResultsRenderer?.toJson(),
    };

SingleColumnMusicWatchNextResultsRenderer
    _$SingleColumnMusicWatchNextResultsRendererFromJson(
            Map<String, dynamic> json) =>
        SingleColumnMusicWatchNextResultsRenderer(
          json['tabbedRenderer'] == null
              ? null
              : TabbedRenderer.fromJson(
                  json['tabbedRenderer'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SingleColumnMusicWatchNextResultsRendererToJson(
        SingleColumnMusicWatchNextResultsRenderer instance) =>
    <String, dynamic>{
      'tabbedRenderer': instance.tabbedRenderer?.toJson(),
    };

TabbedRenderer _$TabbedRendererFromJson(Map<String, dynamic> json) =>
    TabbedRenderer(
      json['watchNextTabbedResultsRenderer'] == null
          ? null
          : WatchNextTabbedResultsRenderer.fromJson(
              json['watchNextTabbedResultsRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TabbedRendererToJson(TabbedRenderer instance) =>
    <String, dynamic>{
      'watchNextTabbedResultsRenderer':
          instance.watchNextTabbedResultsRenderer?.toJson(),
    };

WatchNextTabbedResultsRenderer _$WatchNextTabbedResultsRendererFromJson(
        Map<String, dynamic> json) =>
    WatchNextTabbedResultsRenderer(
      (json['tabs'] as List<dynamic>?)
          ?.map((e) => Tab.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WatchNextTabbedResultsRendererToJson(
        WatchNextTabbedResultsRenderer instance) =>
    <String, dynamic>{
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
      json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>),
      json['title'] as String?,
    );

Map<String, dynamic> _$TabRendererToJson(TabRenderer instance) =>
    <String, dynamic>{
      'content': instance.content?.toJson(),
      'navigationEndpoint': instance.navigationEndpoint?.toJson(),
      'title': instance.title,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      json['musicQueueRenderer'] == null
          ? null
          : MusicQueueRenderer.fromJson(
              json['musicQueueRenderer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'musicQueueRenderer': instance.musicQueueRenderer?.toJson(),
    };
