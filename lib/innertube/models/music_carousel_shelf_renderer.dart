import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/button_renderer.dart';
import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/innertube/models/music_two_row_item_renderer.dart';
import 'package:monophony/innertube/models/runs.dart';

part 'music_carousel_shelf_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class MusicCarouselShelfRenderer {
  Header? header;
  List<Content>? contents;

  MusicCarouselShelfRenderer(this.header, this.contents);

  factory MusicCarouselShelfRenderer.fromJson(Map<String, dynamic> json) => _$MusicCarouselShelfRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicCarouselShelfRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  MusicTwoRowItemRenderer? musicTwoRowItemRenderer;
  MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;

  Content(this.musicResponsiveListItemRenderer, this.musicTwoRowItemRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Header {
  MusicTwoRowItemRenderer? musicTwoRowItemRenderer;
  MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;
  MusicCarouselShelfBasicHeaderRenderer? musicCarouselShelfBasicHeaderRenderer;

  Header(this.musicCarouselShelfBasicHeaderRenderer, this.musicResponsiveListItemRenderer, this.musicTwoRowItemRenderer);

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicCarouselShelfBasicHeaderRenderer {
  MoreContentButton? moreContentButton;
  Runs? title;
  Runs? strapline;

  MusicCarouselShelfBasicHeaderRenderer(this.strapline, this.title);

  factory MusicCarouselShelfBasicHeaderRenderer.fromJson(Map<String, dynamic> json) => _$MusicCarouselShelfBasicHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicCarouselShelfBasicHeaderRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoreContentButton {
  ButtonRenderer? buttonRenderer;

  MoreContentButton(this.buttonRenderer);

  factory MoreContentButton.fromJson(Map<String, dynamic> json) => _$MoreContentButtonFromJson(json);
  Map<String, dynamic> toJson() => _$MoreContentButtonToJson(this);
}