import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';

part 'automix_preview_video_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class AutomixPreviewVideoRenderer {
  Content? content;

  AutomixPreviewVideoRenderer(this.content);

  factory AutomixPreviewVideoRenderer.fromJson(Map<String, dynamic> json) => _$AutomixPreviewVideoRendererFromJson(json);
  Map<String, dynamic> toJson() => _$AutomixPreviewVideoRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  AutomixPlaylistVideoRenderer? automixPlaylistVideoRenderer;

  Content(this.automixPlaylistVideoRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AutomixPlaylistVideoRenderer {
  NavigationEndpoint? navigationEndpoint;

  AutomixPlaylistVideoRenderer(this.navigationEndpoint);

  factory AutomixPlaylistVideoRenderer.fromJson(Map<String, dynamic> json) => _$AutomixPlaylistVideoRendererFromJson(json);
  Map<String, dynamic> toJson() => _$AutomixPlaylistVideoRendererToJson(this);
}