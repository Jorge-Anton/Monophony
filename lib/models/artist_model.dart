class ArtistModel {
  final String name;
  final String thumbnail;
  final String subscribers;

  const ArtistModel({
    required this.name,
    required this.thumbnail,
    required this.subscribers
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    final flexColumns = json["musicResponsiveListItemRenderer"]["flexColumns"];
    final String name = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["text"];
    final String subscribers = flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"].last["text"].toString().replaceFirst(RegExp(r'subscribers'), 'subscriptores');
    final String thumbnail = json["musicResponsiveListItemRenderer"]["thumbnail"]["musicThumbnailRenderer"]["thumbnail"]["thumbnails"][0]["url"] + '-w224-h224';

    return ArtistModel(name: name, thumbnail: thumbnail, subscribers: subscribers);
  }

}