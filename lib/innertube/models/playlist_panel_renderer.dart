import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/automix_preview_video_renderer.dart';
import 'package:monophony/innertube/models/continuation.dart';
import 'package:monophony/innertube/models/playlist_panel_video_renderer.dart';

part 'playlist_panel_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistPanelRenderer {
  List<Content>? contents;
  List<Continuation>? continuations;

  PlaylistPanelRenderer(this.contents, this.continuations);

  factory PlaylistPanelRenderer.fromJson(Map<String, dynamic> json) => _$PlaylistPanelRendererFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistPanelRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  PlaylistPanelVideoRenderer? playlistPanelVideoRenderer;
  AutomixPreviewVideoRenderer? automixPreviewVideoRenderer;

  Content(this.automixPreviewVideoRenderer, this.playlistPanelVideoRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}