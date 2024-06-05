import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/models/destination_info_model.dart';
import 'package:monophony/views/artist_results_page.dart';
import 'package:monophony/views/song_results_page.dart';

final List<Widget> resultViews = [
  const SongResultsPage(),
  const Center(
    child: Text('Albums'),
  ),
  const ArtistResultsPage(),
  const Center(
    child: Text('Listas'),
  ),
  const Center(
    child: Text('Destacado'),
  )
];

final List<DestinationInfoModel> resultDestinations = [
  DestinationInfoModel(
      iconName: FontAwesomeIcons.music, 
      name: 'Canciones'
    ),
    DestinationInfoModel(
      iconName: FontAwesomeIcons.recordVinyl, 
      name: 'Albums'
    ),
    DestinationInfoModel(
      iconName: FontAwesomeIcons.solidUser, 
      name: 'Artistas'
    ),
    DestinationInfoModel(
      iconName: FontAwesomeIcons.list, 
      name: 'Listas'
    ),
    DestinationInfoModel(
      iconName: FontAwesomeIcons.list, 
      name: 'Destacado'
    )
];