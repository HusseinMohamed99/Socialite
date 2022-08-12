abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates
{
  final String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates{

  final String error;

  LoginErrorState(this.error);
}

class ShowPasswordState extends LoginStates{}

// get user Reload states
class LoginReloadLoadingState extends LoginStates {}
class LoginReloadSuccessState extends LoginStates {}
class LoginReloadErrorState extends LoginStates {
  final String? errorString ;
  LoginReloadErrorState(this.errorString);
}