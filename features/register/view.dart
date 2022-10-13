import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/characters/view.dart';
import 'package:untitled/features/register/cubit.dart';
import 'package:untitled/features/register/states.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Register',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          body: BlocListener<RegisterCubit, RegisterStates>(
            listener: (context, state) {
             if(state is RegesterSuccesstStates){
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>CharactersView(),
               ));

             }else if(state is RegesterErrorStates){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),));

             }
            },
            child: Builder(
              builder: (context) {
                final cubit = BlocProvider.of<RegisterCubit>(context);

                return Form(
                  key: cubit.formKay,
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        onSaved: (v) => cubit.name = v,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            fillColor: Color(0xffF2F2F2),
                            labelText: 'name',
                            hintText: "enter your name"),
                        validator: (v){
                          if(v == null || v.isEmpty){
                            return "name can not be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onSaved: (v) => cubit.phone = v,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            fillColor: Color(0xffF2F2F2),
                            labelText: 'phone',
                            hintText: "enter your phone"),
                        validator: (v){
                          if(v == null || v.isEmpty){
                            return "phone can not be empty";
                          }else if(!v.startsWith('+201')){
                            return "phone must start with +201";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
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
                      BlocBuilder<RegisterCubit, RegisterStates>(
                        builder: (context, state) {
                          if (state is RegesterLoadingStates) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: cubit.register,
                            child: Text('Register'),
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
