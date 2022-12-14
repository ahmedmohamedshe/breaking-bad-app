import 'package:dio/dio.dart';

import '../../models/character.dart';

class CharacterController {
  List<Character> characters = [];
  String? error;
  Future<void> getAllCharacter() async {
    try {
      final response =
          await Dio().get('https://www.breakingbadapi.com/api/characters');

      for (var i in response.data) {
        characters
            .add(Character(name: i['name'], image: i['img'], id: i['char_id']));
      }
    } catch (e) {
      error = 'somthing is wrong';
      print('ERROR');
    }
  }
}
