import 'package:app/package/data/models/characters.dart';
import 'package:app/package/data/repository/characters_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));

      this.characters = characters;
    });
    return characters;
  }
}
