import 'package:monophony/innertube/models/music_responsive_list_item_renderer.dart';
import 'package:monophony/models/thumbnail_model.dart';

class ArtistModel {
  final String name;
  final ThumbnailModel? thumbnail;
  final String subscribers;
  final String browseId;

  const ArtistModel({
    required this.name,
    required this.thumbnail,
    required this.subscribers,
    required this.browseId
  });

  // factory ArtistModel.fromJson(Map<String, dynamic> json) {
  //   final flexColumns = json["musicResponsiveListItemRenderer"]["flexColumns"];
  //   final String name = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["text"];
  //   final String subscribers = flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"].last["text"].toString().replaceFirst(RegExp(r'subscribers'), 'subscriptores');
  //   final String thumbnail = json["musicResponsiveListItemRenderer"]["thumbnail"]["musicThumbnailRenderer"]["thumbnail"]["thumbnails"][0]["url"] + '-w224-h224';
  //   final String browseId = json["musicResponsiveListItemRenderer"]["navigationEndpoint"]["browseEndpoint"]["browseId"];

  //   return ArtistModel(name: name, thumbnail: thumbnail, subscribers: subscribers, browseId: browseId);
  // }

  factory ArtistModel.fromMusicResponsiveListItemRenderer(MusicResponsiveListItemRenderer renderer) {
    final name = renderer.flexColumns.firstOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.text ?? '';
    final thumbnail = renderer.thumbnail?.musicThumbnailRenderer?.thumbnail?.thumbnails?.firstOrNull;
    final subscribers = renderer.flexColumns.lastOrNull?.musicResponsiveListItemFlexColumnRenderer?.text?.splitBySeparator().lastOrNull ?? '';
    final browseId = renderer.navigationEndpoint?.browseEndpoint?.browseId ?? '';
    return ArtistModel(name: name, thumbnail: thumbnail, subscribers: subscribers, browseId: browseId);
  }

}