import 'package:app/package/business_logic/characters_cubit.dart';
import 'package:app/package/constanse/my_colors.dart';
import 'package:app/package/data/models/characters.dart';
import 'package:app/package/presentation/screens/widget/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters; // عمل ليست ويكون داخلها الكاركتر
// الذي يتم البحث عنه فقط وليس جميعهم
  bool isSearching = false; //وهذا لمعرفة اذا كنت اعمل سيرش الان ام لا
  final _searchedTextController = TextEditingController(); // وهذا لنتمكن من
  // البحث داخلا appBar

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildSearchField() {
    return TextFormField(
      controller: _searchedTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
          hintText: 'find a character',
          hintStyle: TextStyle(
            color: MyColors.myGrey,
            fontSize: 18,
          ),
          border: InputBorder.none),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter); //اخذ الحرف الذي
        // كتب داخل string وعمل فلتره له
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchedTextController.clear();
    });
  }

  Widget _buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return _showLoadingIndicator();
      }
    });
  }

  Widget _showLoadingIndicator() {
    return Container(
      color: MyColors.myGrey,
      child: const Center(
        child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ),
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildCharacterList(),
        ],
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchedTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (_, index) {
          return CharacterItem(
            character: _searchedTextController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget _buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Can/,t connect .. check internet',
              style: TextStyle(color: MyColors.myGrey, fontSize: 22),
            ),
            Image.asset('image/not-found.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        centerTitle: true,
        title: isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarAction(),
        leading: isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
      ),
      backgroundColor: MyColors.myGrey,
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return _buildBlocWidget();
          } else {
            return _buildNoInternetWidget();
          }
        },
        child: _showLoadingIndicator(),
      ),
    );
  }
}
