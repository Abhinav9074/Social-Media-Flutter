abstract class LoginEvent{}

class LoggedInEvent extends LoginEvent{}

class ManualLoginEvent extends LoginEvent{
  final String email;
  final String password;

  ManualLoginEvent({required this.email, required this.password});
}
class ManualSignUpEvent extends LoginEvent{
  final String email;
  final String password;

  ManualSignUpEvent({required this.email, required this.password});
}

