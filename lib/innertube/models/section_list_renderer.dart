import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/continuation.dart';
import 'package:monophony/innertube/models/grid_renderer.dart';
import 'package:monophony/innertube/models/music_carousel_shelf_renderer.dart';
import 'package:monophony/innertube/models/music_shelf_renderer.dart';
import 'package:monophony/innertube/models/runs.dart';

part 'section_list_renderer.g.dart';

@JsonSerializable()
class SectionListRenderer {
  List<Content>? contents;
  List<Continuation>? continuations;

  SectionListRenderer(this.contents, this.continuations);

  factory SectionListRenderer.fromJson(Map<String, dynamic> json) => _$SectionListRendererFromJson(json);
  Map<String, dynamic> toJson() => _$SectionListRendererToJson(this);

  Content? findSectionByTitle(String text) {
    return contents?.cast<Content?>().firstWhere((Content? content) {
      final title = content?.musicCarouselShelfRenderer?.header?.musicCarouselShelfBasicHeaderRenderer?.title ?? content?.musicShelfRenderer?.title;
      return title?.runs.firstOrNull?.text == text;
    },
    orElse: () => null
    );
  }

}

Object? mapper1(json, field) => json["musicCarouselShelfRenderer"] ?? json["musicImmersiveHeaderRenderer"];
Object? mapper2(json, field) => json["musicShelfRenderer"] ?? json["musicPlaylistShelfRenderer"];

@JsonSerializable()
class Content {
  @JsonKey(readValue: mapper1)
  MusicCarouselShelfRenderer? musicCarouselShelfRenderer;
  @JsonKey(readValue: mapper2)
  MusicShelfRenderer? musicShelfRenderer;
  GridRenderer? gridRenderer;
  MusicDescriptionShelfRenderer? musicDescriptionShelfRenderer;

  Content(this.musicCarouselShelfRenderer, this.musicShelfRenderer, this.gridRenderer, this.musicDescriptionShelfRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MusicDescriptionShelfRenderer {
  Runs? description;

  MusicDescriptionShelfRenderer(this.description);

  factory MusicDescriptionShelfRenderer.fromJson(Map<String, dynamic> json) => _$MusicDescriptionShelfRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MusicDescriptionShelfRendererToJson(this);
}