import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/innertube/get_search_suggestions.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/search_results/results_page.dart';
import 'package:monophony/widgets/my_text_field.dart';

class OnlineSearchPage extends StatefulWidget {
  const OnlineSearchPage({super.key});

  @override
  State<OnlineSearchPage> createState() => _OnlineSearchPageState();
}

class _OnlineSearchPageState extends State<OnlineSearchPage> {
  late TextEditingController _controller;
  late ActiveSearchNotifier _activeSearchNotifier;
  Timer? _debounce;
  final int _debounceTime = 250;
  List<String> _searchResults = [];
  bool _networkError = false;

  @override
  void initState() {
    super.initState();
    _activeSearchNotifier = getIt<ActiveSearchNotifier>();
    _controller = TextEditingController(text: _activeSearchNotifier.value);
    _controller.addListener(onQueryChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(onQueryChanged);
    _controller.dispose();
    super.dispose();
  }

  void onQueryChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceTime), () async {
      if (_controller.text != '') {
        try {
          final result = await getSearchSuggestions(_controller.text);
          setState(() {
            _networkError = false;
            _searchResults = result;
          });
        } catch (e) {
          if (mounted) {
            setState(() {
              _networkError = true;
            });
          } else {
            _networkError = true;
          }
        }
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // _controller.text = ref.watch(activeSearchControllerProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusBarHeight + 32.0, right: 10.0),
            child: MyTextField(
              controller: _controller,
              autofocus: true,
              onSubmitted: (value) {
                // ref.read(activeSearchControllerProvider.notifier).setActiveSearch(value);
                _activeSearchNotifier.setActiveSearch(value);
                Navigator.of(context).pushAndRemoveUntil(createRoute(const ResultsPage()), ModalRoute.withName("/"));
              },
              hintText: 'Busca algo',
            ),
          ),
          Opacity(
            opacity: _controller.text == '' ? 0.0 : 1.0,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 5.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonal(
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _searchResults.clear();
                    });
                  }, 
                  child: const Text('Borrar')
                ),
              ),
            ),
          ),
          if (_networkError)
            const Text('Error de conexión')
          else
            for (final item in _searchResults)
              ListTile(
                contentPadding: const EdgeInsets.only(right: 2.0, left: 25.0),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      visualDensity: const VisualDensity(horizontal: -4),
                      onPressed: () {
                        _controller.text = item;
                      }, 
                      icon: Transform.scale(
                        scaleX: -1,
                        child: Icon(
                          Icons.arrow_outward_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    )
                  ],
                ),
                onTap: () {
                  // ref.read(activeSearchControllerProvider.notifier).setActiveSearch(item);
                  _activeSearchNotifier.setActiveSearch(item);
                  Navigator.of(context).pushAndRemoveUntil(createRoute(const ResultsPage()), ModalRoute.withName("/"));
                },
                title: Text(
                  item,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary
                  ),
                ),
                // TODO: añadir leading para los históricos
              )
        ],
      ),
    );
  }
}