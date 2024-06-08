import 'package:json_annotation/json_annotation.dart';

part 'thumbnail_model.g.dart';

@JsonSerializable()
class ThumbnailModel {
  String url;
  int? height;
  int? width;

  ThumbnailModel(this.url, this.height, this.width);

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) => _$ThumbnailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailModelToJson(this);

  bool get isResizable => !url.startsWith('https://i.ytimg.com');

  String size(int size) {
    return switch (url) {
      String s when s.startsWith('https://lh3.googleusercontent.com') => "$url-w$size-h$size",
      String s when s.startsWith('https://yt3.ggpht.com') => "$url-s$size",
      _ => url
    };
  }
}