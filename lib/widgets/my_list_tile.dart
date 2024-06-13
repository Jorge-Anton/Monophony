import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/models/list_model.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.list,
    required this.onTap
  });

  final ListModel list;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 14.0, top: 9.0, bottom: 9.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: list.thumbnail?.size(120) ?? '',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    ),
                  );
                }
              ),
            ),
            const SizedBox(width: 12.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      list.artist,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}