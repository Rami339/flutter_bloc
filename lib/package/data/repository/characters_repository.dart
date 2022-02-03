import 'package:app/package/data/api/characters_api.dart';
import 'package:app/package/data/models/characters.dart';

class CharactersRepository {
  late CharactersApi charactersApi;

  CharactersRepository(this.charactersApi);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersApi.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
