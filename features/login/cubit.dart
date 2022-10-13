import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/features/login/states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitStates());
  String? email;
  String? password;
  final formKay = GlobalKey<FormState>();
  Future<void> Login() async{
    if (!formKay.currentState!.validate()){
      return;
    }
    formKay.currentState!.save();
    emit(LoginLoadingStates());
    try{
      final response = await Dio().post('https://student.valuxapps.com/api/Login',
          data: {

            "email": email,
            "password": password,
          }

      );

      if(response.data['status']){
        SharedPreferences sp =await SharedPreferences.getInstance();
        sp.setString('token',response.data['data']['token']);
        emit(LoginSuccesstStates());
      }else{
        emit(LoginErrorStates(
            message: response.data['message']
        ));
      }
    }catch(e){
      emit(LoginErrorStates(
        message: e.toString(),
      ));
    }
  }


}