import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/music_two_row_item_renderer.dart';

part 'grid_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class GridRenderer {
  List<Item>? items;

  GridRenderer(this.items);

  factory GridRenderer.fromJson(Map<String, dynamic> json) => _$GridRendererFromJson(json);
  Map<String, dynamic> toJson() => _$GridRendererToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Item {
  MusicTwoRowItemRenderer? musicTwoRowItemRenderer;

  Item(this.musicTwoRowItemRenderer);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}