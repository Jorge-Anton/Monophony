import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monophony/models/artist_model.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({
    super.key,
    required this.artist,
    required this.onTap
  });

  final ArtistModel artist;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 2, vertical: 2),
      minTileHeight: 80,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: CachedNetworkImage(
          imageUrl: artist.thumbnail?.size(120) ?? '',
          width: 64,
          height: 64,
        ),
      ),
      title: Text(
        artist.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        artist.subscribers,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w600
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}