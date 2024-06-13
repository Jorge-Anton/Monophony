import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/innertube/get_search_suggestions.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/search_results/results_page.dart';
import 'package:monophony/widgets/my_text_field.dart';

class OnlineSearchPage extends ConsumerStatefulWidget {
  const OnlineSearchPage({super.key});

  @override
  ConsumerState<OnlineSearchPage> createState() => _OnlineSearchPageState();
}

class _OnlineSearchPageState extends ConsumerState<OnlineSearchPage> {
  late TextEditingController _controller;
  late ActiveSearchNotifier _activeSearchNotifier;

  @override
  void initState() {
    super.initState();
    _activeSearchNotifier = getIt<ActiveSearchNotifier>();
    _controller = TextEditingController(text: _activeSearchNotifier.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<String?>> searchResults = ref.watch(getSearchSuggestionsProvider);
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
            child: MyTextField(
              controller: _controller,
              autofocus: true,
              onSubmitted: (value) {
                if (value != '') {
                  _activeSearchNotifier.setActiveSearch(value);
                  Navigator.of(context).pushAndRemoveUntil(createRoute(const ResultsPage()), ModalRoute.withName("/"));
                }
              },
              onChanged: (value) => ref.read(queryNotifierProvider.notifier).updateQuery(value),
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
                      ref.read(queryNotifierProvider.notifier).updateQuery('');
                    });
                  }, 
                  child: const Text('Borrar')
                ),
              ),
            ),
          ),
          Column(
            children: [
              searchResults.when(
                data: (results) {
                  if (results.isEmpty) return const SizedBox.shrink();
                  return Column(
                    children: [
                      for (final result in results)
                      if (result != null)
                      ListTile(
                        contentPadding: const EdgeInsets.only(right: 2.0, left: 25.0),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              visualDensity: const VisualDensity(horizontal: -4),
                              onPressed: () {
                                _controller.text = result;
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
                          _activeSearchNotifier.setActiveSearch(result);
                          Navigator.of(context).pushAndRemoveUntil(createRoute(const ResultsPage()), ModalRoute.withName("/"));
                        },
                        title: Text(
                          result,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                        // TODO: añadir leading para los históricos
                      )
                    ],
                  );
                }, 
                error: (error, stackTrace) => const Text('Ha ocurrido un error'), 
                loading: () => const SizedBox.shrink(),
              )
            ],
          )
        ],
      ),
    );
  }
}