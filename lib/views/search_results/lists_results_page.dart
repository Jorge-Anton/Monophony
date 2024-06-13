import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monophony/innertube/search/get_lists.dart';
import 'package:monophony/models/list_model.dart';
import 'package:monophony/notifiers/active_search_controller.dart';
import 'package:monophony/services/service_locator.dart';
import 'package:monophony/utils/create_route.dart';
import 'package:monophony/views/lists/list_page.dart';
import 'package:monophony/views/search/search_page.dart';
import 'package:monophony/widgets/my_list_tile.dart';
import 'package:monophony/widgets/my_text_field.dart';

class ListsResultsPage extends ConsumerWidget {
  const ListsResultsPage({super.key});

  static final ActiveSearchNotifier _activeSearchNotifier = getIt<ActiveSearchNotifier>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final TextEditingController controller = TextEditingController(text: _activeSearchNotifier.value);
    final AsyncValue<List<ListModel>?> listsResults = ref.watch(getListsProvider(_activeSearchNotifier.value));
    return listsResults.when(
      data: (result) {
        if (result == null) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
                child: MyTextField(
                  controller: controller,
                  readOnly: true,
                  enabled: false,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Text('No se han encontrado resultados'),
              )
            ],
          );
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: result.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(createRoute(const MySearchPage()), ModalRoute.withName("/"));
                      },
                      child: MyTextField(
                        controller: controller,
                        readOnly: true,
                        enabled: false,
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.translate(
                          offset: const Offset(10.0, 0),
                          child: IconButton(
                            onPressed: () {}, 
                            icon: const Icon(Icons.bookmark_add_outlined),
                            iconSize: 22,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                          ),
                        ),
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon(Icons.share_rounded),
                          iconSize: 22,
                        )
                      ],
                    ),
                  ),
                ],
              );
            }

            index -= 1;

            return MyListTile(
              list: result[index],
              onTap: () {
                Navigator.push(context, createRoute(ListPage(list: result[index])));
              },
            );
          },
        );
      }, 
      error: (error, stackTrace) => Text(error.toString()), 
      loading: () {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: statusBarHeight + 30.0, right: 10.0),
              child: MyTextField(
                controller: controller,
                readOnly: true,
                enabled: false,
              ),
            ),
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        );
      },
    );
  }
}