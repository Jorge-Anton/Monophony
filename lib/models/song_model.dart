class SongModel {
  final String title;
  final List<String> artists;
  final String thumbnail;
  final String duration;
  final String id;

  const SongModel({
    required this.title,
    required this.artists,
    required this.thumbnail,
    required this.duration,
    required this.id
  });

  factory SongModel.fromSearchJson(Map<String, dynamic> json) {
    final flexColumns = json["musicResponsiveListItemRenderer"]["flexColumns"];
    final String title = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["text"];

    final List<String> artists = [];
    for (final artist in flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"]) {
      if (artist["text"] == " • ") break;
      artists.add(artist["text"]);   
    }
    // final String artist = artistsList.join(" ");

    final String thumbnail = json["musicResponsiveListItemRenderer"]["thumbnail"]["musicThumbnailRenderer"]["thumbnail"]["thumbnails"].last["url"];

    final String duration = flexColumns[1]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"].last["text"];

    final String id = flexColumns[0]["musicResponsiveListItemFlexColumnRenderer"]["text"]["runs"][0]["navigationEndpoint"]["watchEndpoint"]["videoId"];

    return SongModel(title: title, artists: artists, thumbnail: thumbnail, duration: duration, id: id);
  }

  factory SongModel.fromNextJson(Map<String, dynamic> json) {
    final String title = json["playlistPanelVideoRenderer"]["title"]["runs"][0]["text"];

    final List<String> artists = [];
    for (final artist in json["playlistPanelVideoRenderer"]["longBylineText"]["runs"]) {
      if (artist["text"] == " • ") break;
      artists.add(artist["text"]);
    }
    // final String artist = artistsList.join(" ");

    final String thumbnail = json["playlistPanelVideoRenderer"]["thumbnail"]["thumbnails"][0]["url"];

    final String duration = json["playlistPanelVideoRenderer"]["lengthText"]["runs"][0]["text"];

    final String id = json["playlistPanelVideoRenderer"]["navigationEndpoint"]["watchEndpoint"]["videoId"];

    return SongModel(title: title, artists: artists, thumbnail: thumbnail, duration: duration, id: id);
  }
}