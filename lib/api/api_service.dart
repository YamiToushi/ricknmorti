import 'dart:convert';
import 'package:http/http.dart' as http;

class RickAndMortyApi {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<dynamic>> fetchCharacters({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/character/?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
