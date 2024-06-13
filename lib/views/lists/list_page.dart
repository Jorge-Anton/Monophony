import 'package:flutter/material.dart';
import 'package:monophony/models/list_model.dart';
import 'package:monophony/notifiers/view_notifier.dart';
import 'package:monophony/views/lists/list_views.dart';
import 'package:monophony/views/my_page_view.dart';
import 'package:monophony/widgets/my_back_button.dart';
import 'package:monophony/widgets/my_side_bar.dart';

class ListPage extends StatelessWidget {
  const ListPage({
    super.key,
    required this.list
  });

  final ListModel list;

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
            destinations: listDestinations,
            viewNotifer: viewNotifier
          ),
          Expanded(
            child: MyPageView(
              views: listViews(list: list), 
              pageController: pageController, 
              viewNotifier: viewNotifier
            )
          )
        ],
      )
    );
  }
}