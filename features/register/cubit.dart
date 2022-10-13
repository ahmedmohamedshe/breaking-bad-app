import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/features/register/states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegesterInitStates());
  String? name;
  String? phone;
  String? email;
  String? password;
  final formKay = GlobalKey<FormState>();
  Future<void> register() async{
if (!formKay.currentState!.validate()){
  return;
}
formKay.currentState!.save();
emit(RegesterLoadingStates());
 try{
   final response = await Dio().post('https://student.valuxapps.com/api/register',
       data: {
         "name": name,
         "phone": phone,
         "email": email,
         "password": password,
       }

   );

   if(response.data['status']){
     SharedPreferences sp =await SharedPreferences.getInstance();
     sp.setString('token',response.data['data']['token']);
     print(sp.getString('token'));

     emit(RegesterSuccesstStates());
   }else{
     emit(RegesterErrorStates(
       message: response.data['message']
     ));
   }
 }catch(e){
   emit(RegesterErrorStates(
     message: e.toString(),
   ));
 }
  }


}