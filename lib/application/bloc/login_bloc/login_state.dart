abstract class LoginState{}

class LoginInitialState extends LoginState{}

class LoginFailedState extends LoginState{}

class LoginLoadingState extends LoginState{}

class ManualLoginLoadingState extends LoginState{}

class UserExistState extends LoginState{
  final String username;
  final String email;

  UserExistState({required this.username, required this.email});
  
}

class NewUserState extends LoginState{
  final String username;
  final String email;

  NewUserState({required this.username, required this.email});
}

class UserBlockedState extends LoginState{}

class NoInternetState extends LoginState{}

class NoUserState extends LoginState{}
