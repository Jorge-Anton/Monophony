import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/runs.dart';
import 'package:monophony/innertube/models/thumbnail_renderer.dart';

part 'music_responsive_list_item_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicResponsiveListItemRenderer {
  List<FlexColumn>? fixedColumns;
  List<FlexColumn> flexColumns;
  ThumbnailRenderer? thumbnail;

  MusicResponsiveListItemRenderer(this.fixedColumns, this.flexColumns, this.thumbnail);

  factory MusicResponsiveListItemRenderer.fromJson(Map<String, dynamic> json) => _$MusicResponsiveListItemRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicResponsiveListItemRendererToJson(this);
}

Object? mapper(json, field) => json["musicResponsiveListItemFlexColumnRenderer"] ?? json["musicResponsiveListItemFixedColumnRenderer"];

@JsonSerializable(explicitToJson: true)
class FlexColumn {
  @JsonKey(readValue: mapper)
  MusicResponsiveListItemFlexColumnRenderer? musicResponsiveListItemFlexColumnRenderer;

  FlexColumn(this.musicResponsiveListItemFlexColumnRenderer);

  factory FlexColumn.fromJson(Map<String, dynamic> json) => _$FlexColumnFromJson(json);
  Map<String, dynamic> toJson() => _$FlexColumnToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicResponsiveListItemFlexColumnRenderer {
  Runs? text;

  MusicResponsiveListItemFlexColumnRenderer(this.text);

  factory MusicResponsiveListItemFlexColumnRenderer.fromJson(Map<String, dynamic> json) => _$MusicResponsiveListItemFlexColumnRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicResponsiveListItemFlexColumnRendererToJson(this);
}