import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:ricknmorti/api/api_service.dart';
import '../models/character.dart';

class CharacterProvider with ChangeNotifier {
  final RickAndMortyApi _api = RickAndMortyApi();
  List<Character> _characters = [];
  late Box<Character> _charactersBox;
  late Box<Character> _favoritesBox;
  int _currentPage = 1;
  bool _isLoading = false;

  CharacterProvider() {
    _charactersBox = Hive.box('characters');
    _favoritesBox = Hive.box('favorites');
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    if (_charactersBox.isNotEmpty) {
      _characters = _charactersBox.values.toList();
    } else {
      await fetchCharactersFromApi();
    }
    _updateFavoriteStatus();
    notifyListeners();
  }

  Future<void> fetchCharactersFromApi({int page = 1}) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      final characterData = await _api.fetchCharacters(page: page);
      final newCharacters = characterData.map((json) => Character.fromJson(json)).toList();

      for (var character in newCharacters) {
        _charactersBox.put(character.id, character);
        _characters.add(character);
      }
      _updateFavoriteStatus();
      _currentPage++;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching characters: $e");
      }
    }
    _isLoading = false;
  }

  void _updateFavoriteStatus() {
    for (var character in _characters) {
      if (_favoritesBox.containsKey(character.id)) {
        character.isFavorite = true;
      }
    }
  }

  void toggleFavorite(Character character) {
    final index = _characters.indexWhere((c) => c.id == character.id);
    if (index != -1) {
      _characters[index] = character.copyWith(isFavorite: !character.isFavorite);
    }
    if (_favoritesBox.containsKey(character.id)) {
      _favoritesBox.delete(character.id);
    } else {
      _favoritesBox.put(character.id, character.copyWith(isFavorite: true));
    }
    notifyListeners();
  }

  List<Character> get characters => _characters;

  List<Character> get favorites => _favoritesBox.values.toList();

  Future<void> loadMoreCharacters() async {
    await fetchCharactersFromApi(page: _currentPage);
  }
}
