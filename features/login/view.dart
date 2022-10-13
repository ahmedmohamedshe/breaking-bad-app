import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/characters/view.dart';
import 'package:untitled/features/login/states.dart';

import 'cubit.dart';


class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          body: BlocListener<LoginCubit, LoginStates>(
            listener: (context, state) {
              if(state is LoginSuccesstStates){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>CharactersView(),
                ));

              }else if(state is LoginErrorStates){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),));

              }
            },
            child: Builder(
              builder: (context) {
                final cubit = BlocProvider.of<LoginCubit>(context);

                return Form(
                  key: cubit.formKay,
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      SizedBox(
                        height: 50,
                      ),

                      TextFormField(
                        onSaved: (v) => cubit.email = v,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            fillColor: Color(0xffF2F2F2),
                            labelText: 'Email',
                            hintText: "enter your email"),
                        validator: (v){
                          if(v == null || v.isEmpty){
                            return "email can not be empty";
                          }else if(!v.contains('@')){
                            return "Email must be contain @";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onSaved: (v) => cubit.password = v,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            fillColor: Color(0xffF2F2F2),
                            labelText: 'password',
                            hintText: "enter your password"),
                        validator: (v){
                          if(v == null || v.isEmpty){
                            return "password can not be empty";
                          }else if(v.length < 6){
                            return "password must be at least 6 character";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 100),
                      BlocBuilder<LoginCubit, LoginStates>(
                        builder: (context, state) {
                          if (state is LoginLoadingStates) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: cubit.Login,
                            child: Text('Login'),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
