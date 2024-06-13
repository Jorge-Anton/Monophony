import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/models/destination_info_model.dart';
import 'package:monophony/models/list_model.dart';
import 'package:monophony/views/lists/list_songs_page.dart';

List<Widget> listViews({required ListModel list}) => [
  ListSongsPage(list: list)
];

final List<DestinationInfoModel> listDestinations = [
  DestinationInfoModel(
    iconName: FontAwesomeIcons.music, 
    name: 'Canciones'
  )
];