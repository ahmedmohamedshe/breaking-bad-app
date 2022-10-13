abstract class RegisterStates{}
class RegesterInitStates extends RegisterStates{}
class RegesterLoadingStates extends RegisterStates{}
class RegesterSuccesstStates extends RegisterStates{}
class RegesterErrorStates extends RegisterStates{
   final String message;

  RegesterErrorStates({required this.message});


}