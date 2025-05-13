import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const CharacterCard({super.key, 
    required this.character,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: character.image,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(character.name),
          subtitle: Text('${character.status} - ${character.species}'),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
            ),
            onPressed: onFavoriteToggle,
          ),
        ),
      ),
    );
  }
}
