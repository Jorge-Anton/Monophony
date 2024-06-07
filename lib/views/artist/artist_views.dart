import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/models/destination_info_model.dart';
import 'package:monophony/views/artist/over_view_page.dart';

final List<Widget> artistViews = [
  const OverViewPage(),
  const Center(
    child: Text('Canciones'),
  ),
  const Center(
    child: Text('Albums'),
  ),
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