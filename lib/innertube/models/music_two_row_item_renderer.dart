import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/runs.dart';
import 'package:monophony/innertube/models/thumbnail_renderer.dart';

part 'music_two_row_item_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicTwoRowItemRenderer {
  // NavigationEndpoint? navigationEndpoint;
  ThumbnailRenderer? thumbnailRenderer;
  Runs? title;
  Runs? subtitle;

  MusicTwoRowItemRenderer(this.thumbnailRenderer, this.title, this.subtitle);

  factory MusicTwoRowItemRenderer.fromJson(Map<String, dynamic> json) => _$MusicTwoRowItemRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicTwoRowItemRendererToJson(this);
}