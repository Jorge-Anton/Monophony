import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/playlist_panel_renderer.dart';

part 'music_queue_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicQueueRenderer {
  Content? content;

  MusicQueueRenderer(this.content);

  factory MusicQueueRenderer.fromJson(Map<String, dynamic> json) => _$MusicQueueRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicQueueRendererToJson(this);
}

Object? mapper(json, field) => json["playlistPanelRenderer"] ?? json["playlistPanelContinuation"];

@JsonSerializable(explicitToJson: true)
class Content {
  @JsonKey(readValue: mapper)
  PlaylistPanelRenderer? playlistPanelRenderer;

  Content(this.playlistPanelRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}