import 'package:app/package/constanse/my_colors.dart';
import 'package:app/package/data/models/characters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: MyColors.myGrey,
      pinned: true,
      stretch: true,
      expandedHeight: 580,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis, //لاث نقط اذ  فس اخر السطر اذ كان كبير
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivide(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                characterInfo('name :', character.name),
                buildDivide(270),
                characterInfo('job :', character.jobs.join('/')),
                buildDivide(290),
                characterInfo('status :', character.status),
                buildDivide(265),
                characterInfo('birthday :', character.birthday),
                buildDivide(250),
                character.betterCallSaulAppearance.isEmpty
                    ? Container()
                    : characterInfo('betterCallSaulAppearance :',
                        character.betterCallSaulAppearance.join('/')),
                buildDivide(105),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 400,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildSliverList(),
        ],
      ),
    );
  }
}
