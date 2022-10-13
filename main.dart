import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/features/characters/view.dart';
import 'package:untitled/features/login/view.dart';

    void main() async{
      WidgetsFlutterBinding.ensureInitialized();
      final sp = await SharedPreferences.getInstance();
      final isLoggedIn =sp.getString('token')!=null;

      runApp ( MyApp(home:isLoggedIn ? CharactersView() : LoginView()));

    }
class MyApp extends StatelessWidget {
  const MyApp({Key? key,required this.home}) : super(key: key);
final Widget home;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
//CharactersView(),
//Container(
//       margin: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(12),
//               ),
//               child: Image.network(
//              character.image,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(character.name ,style: TextStyle(
//               fontSize: 15,fontWeight: FontWeight.bold,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,),
//           ),
//         ],
//       ),
//       decoration:
//           BoxDecoration(
//             color: Colors.white,
//               borderRadius: BorderRadius.circular(12), boxShadow: [
//         BoxShadow(
//           offset: Offset(0, 0),
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 2,
//         )
//       ]),
//     );