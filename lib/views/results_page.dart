import 'package:flutter/material.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/views/result_views.dart';
import 'package:monophony/widgets/my_back_button.dart';
import 'package:monophony/widgets/my_side_bar.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  static final ViewNotifier _viewNotifier = ViewNotifier();
  static final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MySideBar(
            actionButton: const MyBackButton(), 
            destinations: resultDestinations, 
            viewNotifer: _viewNotifier
          ),
          Expanded(
            child: MyPageView(
              viewNotifier: _viewNotifier, 
              pageController: _pageController, 
              views: resultViews
            )
          )
        ],
      ),
    );
  }
}