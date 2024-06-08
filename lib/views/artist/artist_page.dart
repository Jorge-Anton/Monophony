import 'package:flutter/material.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/views/artist/artist_views.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/widgets/my_back_button.dart';
import 'package:monophony/widgets/my_side_bar.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({
    super.key,
    required this.artistName,
    required this.artistId
  });

  final String artistName;
  final String artistId;

  @override
  Widget build(BuildContext context) {
    final ViewNotifier viewNotifier = ViewNotifier();
    final PageController pageController = PageController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MySideBar(
            actionButton: const MyBackButton(), 
            destinations: artistDestinations,
            viewNotifer: viewNotifier
          ),
          Expanded(
            child: MyPageView(
              views: artistViews(artistId: artistId, artistName: artistName), 
              pageController: pageController, 
              viewNotifier: viewNotifier
            )
          )
        ],
      ),
    );
  }
}