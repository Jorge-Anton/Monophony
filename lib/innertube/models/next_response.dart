import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/music_queue_renderer.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';

part 'next_response.g.dart';

@JsonSerializable(explicitToJson: true)
class NextResponse {
  Contents? contents;

  NextResponse(this.contents);

  factory NextResponse.fromJson(Map<String, dynamic> json) => _$NextResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NextResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Contents {
  SingleColumnMusicWatchNextResultsRenderer? singleColumnMusicWatchNextResultsRenderer;

  Contents(this.singleColumnMusicWatchNextResultsRenderer);

  factory Contents.fromJson(Map<String, dynamic> json) => _$ContentsFromJson(json);
  Map<String, dynamic> toJson() => _$ContentsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SingleColumnMusicWatchNextResultsRenderer {
  TabbedRenderer? tabbedRenderer;
  
  SingleColumnMusicWatchNextResultsRenderer(this.tabbedRenderer);

  factory SingleColumnMusicWatchNextResultsRenderer.fromJson(Map<String, dynamic> json) => _$SingleColumnMusicWatchNextResultsRendererFromJson(json);
  Map<String, dynamic> toJson() => _$SingleColumnMusicWatchNextResultsRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TabbedRenderer {
  WatchNextTabbedResultsRenderer? watchNextTabbedResultsRenderer;

  TabbedRenderer(this.watchNextTabbedResultsRenderer);

  factory TabbedRenderer.fromJson(Map<String, dynamic> json) => _$TabbedRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TabbedRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WatchNextTabbedResultsRenderer {
  List<Tab>? tabs;

  WatchNextTabbedResultsRenderer(this.tabs);

  factory WatchNextTabbedResultsRenderer.fromJson(Map<String, dynamic> json) => _$WatchNextTabbedResultsRendererFromJson(json);
  Map<String, dynamic> toJson() => _$WatchNextTabbedResultsRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tab {
  TabRenderer? tabRenderer;

  Tab(this.tabRenderer);

  factory Tab.fromJson(Map<String, dynamic> json) => _$TabFromJson(json);
  Map<String, dynamic> toJson() => _$TabToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TabRenderer {
  Content? content;
  NavigationEndpoint? navigationEndpoint;
  String? title;

  TabRenderer(this.content, this.navigationEndpoint, this.title);

  factory TabRenderer.fromJson(Map<String, dynamic> json) => _$TabRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TabRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  MusicQueueRenderer? musicQueueRenderer;

  Content(this.musicQueueRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}