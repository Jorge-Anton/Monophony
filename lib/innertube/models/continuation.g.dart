// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continuation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Continuation _$ContinuationFromJson(Map<String, dynamic> json) => Continuation(
      mapper(json, 'nextContinuationData') == null
          ? null
          : Data.fromJson(
              mapper(json, 'nextContinuationData') as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContinuationToJson(Continuation instance) =>
    <String, dynamic>{
      'nextContinuationData': instance.nextContinuationData?.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['continuation'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'continuation': instance.continuation,
    };
