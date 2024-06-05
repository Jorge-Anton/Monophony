import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/models/destination_info_model.dart';
import 'package:monophony/views/home_page.dart';

final List<Widget> rootViews = [
  const HomePage(),
  const Center(
    child: Text('2nd Page'),
  ),
  const Center(
    child: Text('3th Page'),
  ),
  const Center(
    child: Text('4th Page'),
  ),
  const Center(
    child: Text('5th Page'),
  )
];

final List<DestinationInfoModel> rootDestinations = [
  DestinationInfoModel(
    iconName: FontAwesomeIcons.house,
    name: 'Inicio',
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.music,
    name: 'Canciones',
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.list,
    name: 'Listas',
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.solidUser,
    name: 'Artistas',
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.recordVinyl,
    name: 'Albums',
  ),
];