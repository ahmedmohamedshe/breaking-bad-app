import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/characters/controller.dart';

import '../../widgets/character_card.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  bool isLoadin = true;
  CharacterController characterController = CharacterController();

  @override
  void initState() {
    characterController.getAllCharacter().then((value) {
      isLoadin = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: characterController.error != null
          ? Center(
              child: Text(characterController.error!),
            )
          : isLoadin
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                  itemCount: characterController.characters.length,
                  itemBuilder: (context, index) => CharacterCard(
                    character: characterController.characters[index],
                  ),
                ),
    );
  }
}
