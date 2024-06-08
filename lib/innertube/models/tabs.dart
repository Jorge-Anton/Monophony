import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/section_list_renderer.dart';

part 'tabs.g.dart';

@JsonSerializable(explicitToJson: true)
class Tabs {
  List<Tab>? tabs;

  Tabs(this.tabs);

  factory Tabs.fromJson(Map<String, dynamic> json) => _$TabsFromJson(json);
  Map<String, dynamic> toJson() => _$TabsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tab {
  TabRenderer? tabRenderer;

  Tab(this.tabRenderer);

  factory Tab.fromJson(Map<String, dynamic> json) => _$TabFromJson(json);
  Map<String, dynamic> toJson() => _$TabToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TabRenderer {
  Content? content;
  String? title;
  String? tabIdentifier;

  TabRenderer(this.content, this.title, this.tabIdentifier);

  factory TabRenderer.fromJson(Map<String, dynamic> json) => _$TabRendererFromJson(json);
  Map<String, dynamic> toJson() => _$TabRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  SectionListRenderer? sectionListRenderer;

  Content(this.sectionListRenderer);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}