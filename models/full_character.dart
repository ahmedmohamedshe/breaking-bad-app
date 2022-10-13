import 'package:untitled/models/character.dart';

class FullCharacter extends Character {
  final String birthday;
  final String nickname;
  final String status;
  FullCharacter({
    required this.birthday,
    required this.nickname,
    required this.status,
    required super.name,
    required super.image,
    required super.id,
  });
}
