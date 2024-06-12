import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/continuation.dart';
import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';
import 'package:monophony/innertube/models/runs.dart';

part 'music_shelf_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicShelfRenderer {
  NavigationEndpoint? bottomEndpoint;
  List<Content>? contents;
  List<Continuation>? continuations;
  Runs? title;

  MusicShelfRenderer(this.contents, this.continuations, this.title);

  factory MusicShelfRenderer.fromJson(Map<String, dynamic> json) => _$MusicShelfRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicShelfRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;

  Content(this.musicResponsiveListItemRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}