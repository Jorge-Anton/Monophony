import 'package:json_annotation/json_annotation.dart';

part 'navigation_endpoint.g.dart';

@JsonSerializable(explicitToJson: true)
class NavigationEndpoint {
  Watch? watchEndpoint;
  WatchPlaylist? watchPlaylistEndpoint;
  Browse? browseEndpoint;
  Search? searchEndpoint;

  NavigationEndpoint(this.browseEndpoint, this.searchEndpoint, this.watchEndpoint, this.watchPlaylistEndpoint);

  factory NavigationEndpoint.fromJson(Map<String, dynamic> json) => _$NavigationEndpointFromJson(json);
  Map<String, dynamic> toJson() => _$NavigationEndpointToJson(this);
}

@JsonSerializable()
class Watch {
  String? playlistId;
  String? videoId;
  String? params;

  Watch(this.playlistId, this.videoId);

  factory Watch.fromJson(Map<String, dynamic> json) => _$WatchFromJson(json);
  Map<String, dynamic> toJson() => _$WatchToJson(this);
}

@JsonSerializable()
class WatchPlaylist {
  String? params;
  String? playlistId;

  WatchPlaylist(this.params, this.playlistId);

  factory WatchPlaylist.fromJson(Map<String, dynamic> json) => _$WatchPlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$WatchPlaylistToJson(this);
}

@JsonSerializable()
class Browse {
  String? params;
  String? browseId;

  Browse(this.browseId, this.params);

  factory Browse.fromJson(Map<String, dynamic> json) => _$BrowseFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseToJson(this);
}

@JsonSerializable()
class Search {
  String? params;
  String query;

  Search(this.params, this.query);

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}

