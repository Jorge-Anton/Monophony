import 'package:flutter/material.dart';
import 'package:monophony/controllers/view_controller.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/views/result_views.dart';
import 'package:monophony/widgets/my_back_button.dart';
import 'package:monophony/widgets/my_side_bar.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  // static final ViewController _viewController = ViewController();
  // static final PageController _pageController = PageController();

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late ViewController _viewController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _viewController = ViewController();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _viewController.dispose();
    super.dispose();
  }

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
            viewController: _viewController
          ),
          Expanded(
            child: MyPageView(
              viewController: _viewController, 
              pageController: _pageController, 
              views: resultViews
            )
          )
        ],
      ),
    );
  }
}