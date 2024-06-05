import 'package:flutter/material.dart';
import 'package:monophony/controllers/view_controller.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/views/search_views.dart';
import 'package:monophony/widgets/my_back_button.dart';
import 'package:monophony/widgets/my_side_bar.dart';

class MySearchPage extends StatelessWidget {
  const MySearchPage({super.key});
  static final ViewController _viewController = ViewController();
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
            destinations: searchDestinations, 
            viewController: _viewController
          ),
          Expanded(
            child: MyPageView(
              views: searchViews, 
              pageController: _pageController, 
              viewController: _viewController
            )
          )
        ],
      ),
    );
  }
}
