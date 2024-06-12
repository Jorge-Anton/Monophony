import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/models/destination_info_model.dart';
import 'package:monophony/views/album/album_songs_page.dart';

List<Widget> albumViews({required AlbumModel album}) => [
  AlbumSongsPage(album: album),
  const Center(
    child: Text('Otras versiones'),
  )
];

final List<DestinationInfoModel> albumDestinations = [
  DestinationInfoModel(
    iconName: FontAwesomeIcons.music, 
    name: 'Canciones'
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.recordVinyl, 
    name: 'Otras versiones'
  )
];