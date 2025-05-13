import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricknmorti/widget/character_card.dart';
import '../providers/character_provider.dart';
import '../providers/theme_provider.dart';
import '../models/character.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CharacterProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RicknMorty'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            provider.loadMoreCharacters();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: provider.characters.length,
          itemBuilder: (context, index) {
            final character = provider.characters[index];
            return CharacterCard(
              character: character,
              isFavorite: character.isFavorite,
              onFavoriteToggle: () => provider.toggleFavorite(character),
              onTap: () => _showCharacterDetails(context, character),
            );
          },
        ),
      ),
    );
  }

  void _showCharacterDetails(BuildContext context, Character character) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl: character.image,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 8),
                Text(
                  character.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('Status: ${character.status}'),
                Text('Species: ${character.species}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
