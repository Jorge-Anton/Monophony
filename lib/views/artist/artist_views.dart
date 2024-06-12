import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/models/destination_info_model.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/views/artist/albums_page.dart';
import 'package:monophony/views/artist/over_view_page.dart';
import 'package:monophony/views/artist/songs_page.dart';

List<Widget> artistViews({required String artistId, required String artistName, required ViewNotifier viewNotifier}) => [
  OverViewPage(artistId: artistId, artistName: artistName, viewNotifier: viewNotifier),
  SongsPage(artistId: artistId, artistName: artistName),
  AlbumsPage(artistId: artistId, artistName: artistName),
  const Center(
    child: Text('Sencillos'),
  ),
  const Center(
    child: Text('Biblioteca'),
  )
];

final List<DestinationInfoModel> artistDestinations = [
  DestinationInfoModel(
    iconName: FontAwesomeIcons.house, 
    name: 'Inicio'
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.music, 
    name: 'Canciones'
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.recordVinyl, 
    name: 'Albums'
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.recordVinyl, 
    name: 'Sencillos'
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.list, 
    name: 'Biblioteca'
  ),
];