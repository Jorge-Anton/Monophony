import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/button_renderer.dart';
import 'package:monophony/innertube/models/runs.dart';
import 'package:monophony/innertube/models/section_list_renderer.dart';
import 'package:monophony/innertube/models/tabs.dart';
import 'package:monophony/innertube/models/thumbnail_renderer.dart';

part 'browse_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BrowseResponse {
  Contents? contents;
  Header? header;

  BrowseResponse(this.contents, this.header);

  factory BrowseResponse.fromJson(Map<String, dynamic> json) => _$BrowseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseResponseToJson(this);
 
}

@JsonSerializable(explicitToJson: true)
class Contents{
  Tabs? singleColumnBrowseResultsRenderer;
  SectionListRenderer? sectionListRenderer;

  Contents(this.singleColumnBrowseResultsRenderer, this.sectionListRenderer);

  factory Contents.fromJson(Map<String, dynamic> json) => _$ContentsFromJson(json);
  Map<String, dynamic> toJson() => _$ContentsToJson(this);
}

Object? mapper(json, field) => json["musicVisualHeaderRenderer"] ?? json["musicImmersiveHeaderRenderer"];

@JsonSerializable(explicitToJson: true)
class Header {
  @JsonKey(readValue: mapper)
  MusicImmersiveHeaderRenderer? musicImmersiveHeaderRenderer;
  MusicDetailHeaderRenderer? musicDetailHeaderRenderer;

  Header(this.musicImmersiveHeaderRenderer, this.musicDetailHeaderRenderer);

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicDetailHeaderRenderer {
  Runs? title;

  MusicDetailHeaderRenderer(this.title);

  factory MusicDetailHeaderRenderer.fromJson(Map<String, dynamic> json) => _$MusicDetailHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicDetailHeaderRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicImmersiveHeaderRenderer {
  Runs? title;
  Runs? description;
  ThumbnailRenderer? thumbnail;
  PlayButton? playButton;
  StartRadioButton? startRadioButton;

  MusicImmersiveHeaderRenderer(this.title, this.description, this.thumbnail);

  factory MusicImmersiveHeaderRenderer.fromJson(Map<String, dynamic> json) => _$MusicImmersiveHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicImmersiveHeaderRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PlayButton {
  ButtonRenderer? buttonRenderer;

  PlayButton(this.buttonRenderer);

  factory PlayButton.fromJson(Map<String, dynamic> json) => _$PlayButtonFromJson(json);
  Map<String, dynamic> toJson() => _$PlayButtonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StartRadioButton {
  ButtonRenderer? buttonRenderer;

  StartRadioButton(this.buttonRenderer);

  factory StartRadioButton.fromJson(Map<String, dynamic> json) => _$StartRadioButtonFromJson(json);
  Map<String, dynamic> toJson() => _$StartRadioButtonToJson(this);
}