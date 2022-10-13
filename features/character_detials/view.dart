import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/full_character.dart';

class CharacterDetailsView extends StatefulWidget {
  const CharacterDetailsView({Key? key, this.charID}) : super(key: key);
  final charID;

  @override
  State<CharacterDetailsView> createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView> {
  bool isLoading = true;
  FullCharacter? fullcharacter;
  @override
  void initState() {
    getData();
    super.initState();
  }
    void getData() async {
      final response = await Dio().get(
        'https://www.breakingbadapi.com/api/characters/${widget.charID}',);

      fullcharacter = FullCharacter(
        birthday: response.data[0]['birthday'],
        nickname: response.data[0]['nickname'],
        status: response.data[0]['status'],
        name: response.data[0]['name'],
        image: response.data[0]['img'],
        id: response.data[0]['char_id'],
      );
      isLoading = false;
      setState(() {});
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading ? Center(child: CircularProgressIndicator(),) :
      ListView(
        children: [
          Image.network(fullcharacter!.image),
          Text(fullcharacter!.name),
          Text(fullcharacter!.nickname),
          Text(fullcharacter!.birthday),
          Text(fullcharacter!.status),
        ],
      ),
    );
  }
}
