abstract class UserNameEvent{}

class UsernameChangeEvent extends UserNameEvent{
  final String username;

  UsernameChangeEvent({required this.username});
  
}

class UserNameResetEvent extends UserNameEvent{}