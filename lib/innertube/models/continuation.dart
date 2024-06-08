import 'package:json_annotation/json_annotation.dart';

part 'continuation.g.dart';

Object? mapper(json, field) => json["nextContinuationData"] ?? json["nextRadioContinuationData"] ?? json["nextContinuationData"];

@JsonSerializable(explicitToJson: true)
class Continuation {
  @JsonKey(readValue: mapper)
  Data? nextContinuationData;

  Continuation(this.nextContinuationData);

  factory Continuation.fromJson(Map<String, dynamic> json) => _$ContinuationFromJson(json);
  Map<String, dynamic> toJson() => _$ContinuationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  String? continuation;

  Data(this.continuation);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}