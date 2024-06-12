import 'package:flutter/material.dart';
import 'package:monophony/models/album_model.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/views/album/album_views.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/widgets/my_back_button.dart';
import 'package:monophony/widgets/my_side_bar.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({
    super.key,
    required this.album
  });

  final AlbumModel album;


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
            destinations: albumDestinations,
            viewNotifer: viewNotifier
          ),
          Expanded(
            child: MyPageView(
              views: albumViews(album: album), 
              pageController: pageController, 
              viewNotifier: viewNotifier
            )
          )
        ],
      ),
    );
  }
}