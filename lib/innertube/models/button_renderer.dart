import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';

part 'button_renderer.g.dart';

@JsonSerializable(explicitToJson: true)
class ButtonRenderer {
  NavigationEndpoint? navigationEndpoint;

  ButtonRenderer(this.navigationEndpoint);

  factory ButtonRenderer.fromJson(Map<String, dynamic> json) => _$ButtonRendererFromJson(json);
  Map<String, dynamic> toJson() => _$ButtonRendererToJson(this);
}