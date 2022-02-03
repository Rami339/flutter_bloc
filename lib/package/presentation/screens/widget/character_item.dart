import 'package:app/package/constanse/my_colors.dart';
import 'package:app/package/constanse/string.dart';
import 'package:app/package/data/models/characters.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(2),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,
              arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.id,
            child: Container(
              color: MyColors.myWhite,
              child: CachedNetworkImage(
                imageUrl: character.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  'image/loading.gif',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('image/error.png'),
              ),
            ),
          ),
          footer: Container(
            width: double.infinity,
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                  fontSize: 16),
              overflow: TextOverflow.ellipsis,
              //عمل نقاط في اخر السر اذ كان الاسم
              // كبير
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class FlutterImage {}
