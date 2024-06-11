import 'package:flutter/material.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/controllers/mini_player_controller.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/search/search_page.dart';
import 'package:monophony/widgets/fabs/hide_on_scroll_fab.dart';

class SearchFab extends StatelessWidget {
  const SearchFab({
    super.key,
    required this.showFabNotifier
  });

  final ValueNotifier<bool> showFabNotifier;

  static final myMiniPlayerController = getIt<MyMiniPlayerController>();


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: myMiniPlayerController.dragDownPercentageNotifier,
      builder: (context, value, _) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: 70 - 70 * value
          ),
          child: HideOnScrollFab(
            showFabNotifier: showFabNotifier, 
            onPressed: () {
              getIt<ActiveSearchNotifier>().setActiveSearch('');
              Navigator.push(context, createRoute(const MySearchPage()));
            },
            child: const Icon(Icons.search_rounded)
          ),
        ); 
      }
    );
  }
}