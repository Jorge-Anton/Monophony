import 'package:json_annotation/json_annotation.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';

part 'runs.g.dart';

@JsonSerializable(explicitToJson: true)
class Runs {
  List<Run> runs = List.empty();

  Runs(this.runs);

  factory Runs.fromJson(Map<String, dynamic> json) => _$RunsFromJson(json);
  Map<String, dynamic> toJson() => _$RunsToJson(this);

  String get text => runs.map((e) => e.text).join();

  List<String> splitBySeparator () {
    final List<String> result = [];
    for (final run in runs) {
      if (run.text == ' • ') break;
      result.add(run.text ?? '');
    }
    return result;
  }

}

@JsonSerializable()
class Run {
  String? text;
  NavigationEndpoint? navigationEndpoint;

  Run(this.text, this.navigationEndpoint);

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);
  Map<String, dynamic> toJson() => _$RunToJson(this);
}