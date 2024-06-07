import 'package:flutter/material.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/views/search_results/result_views.dart';
import 'package:monophony/widgets/my_back_button.dart';
import 'package:monophony/widgets/my_side_bar.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});


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
            destinations: resultDestinations, 
            viewNotifer: viewNotifier
          ),
          Expanded(
            child: MyPageView(
              viewNotifier: viewNotifier, 
              pageController: pageController, 
              views: resultViews
            )
          )
        ],
      ),
    );
  }
}