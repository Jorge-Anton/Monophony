import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monophony/models/destination_info_model.dart';
import 'package:monophony/views/search/online_search_page.dart';

final List<Widget> searchViews = [
  const OnlineSearchPage(),
  const Center(
    child: Text('Library page'),
  )
];

final List<DestinationInfoModel> searchDestinations = [
  DestinationInfoModel(
    iconName: FontAwesomeIcons.globe,
    name: 'Online'
  ),
  DestinationInfoModel(
    iconName: FontAwesomeIcons.list, 
    name: 'Biblioteca'
  )
];