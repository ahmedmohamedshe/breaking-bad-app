abstract class LoginStates{}
class LoginInitStates extends LoginStates{}
class LoginLoadingStates extends LoginStates{}
class LoginSuccesstStates extends LoginStates{}
class LoginErrorStates extends LoginStates{
  final String message;

  LoginErrorStates({required this.message});


}