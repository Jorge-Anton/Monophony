import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';
import 'package:monophony/innertube/models/runs.dart';
import 'package:monophony/innertube/models/thumbnail_renderer.dart';

part 'playlist_panel_video_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistPanelVideoRenderer {
  Runs? title;
  Runs? longBylineText;
  Runs? shortBylineText;
  Runs? lengthText;
  NavigationEndpoint? navigationEndpoint;
  Thumbnail? thumbnail;

  PlaylistPanelVideoRenderer(this.lengthText, this.longBylineText, this.navigationEndpoint, this.shortBylineText, this.thumbnail, this.title);

  factory PlaylistPanelVideoRenderer.fromJson(Map<String, dynamic> json) => _$PlaylistPanelVideoRendererFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistPanelVideoRendererToJson(this);

  Run? findSectionByPageType(String pageType) {
    return longBylineText?.runs?.cast<Run?>().firstWhere((Run? run) {
      return run?.navigationEndpoint?.browseEndpoint?.browseEndpointContextSupportedConfigs?.browseEndpointContextMusicConfig?.pageType == pageType;
    },
    orElse: () => null,
    );

  }
}