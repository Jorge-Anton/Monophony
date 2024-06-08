import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/models/thumbnail_model.dart';

part 'thumbnail_renderer.g.dart';

Object? mapper(json, field) => json["musicThumbnailRenderer"] ?? json["croppedSquareThumbnailRenderer"];

@JsonSerializable(explicitToJson: true)
class ThumbnailRenderer {
  @JsonKey(readValue: mapper)
  MusicThumbnailRenderer? musicThumbnailRenderer;

  ThumbnailRenderer(this.musicThumbnailRenderer);

  factory ThumbnailRenderer.fromJson(Map<String, dynamic> json) => _$ThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicThumbnailRenderer {
  Thumbnail? thumbnail;

  MusicThumbnailRenderer(this.thumbnail);

  factory MusicThumbnailRenderer.fromJson(Map<String, dynamic> json) => _$MusicThumbnailRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicThumbnailRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Thumbnail {
  List<ThumbnailModel>? thumbnails;

  Thumbnail(this.thumbnails);

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}