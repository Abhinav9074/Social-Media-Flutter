abstract class AddDetailsEvent {}

class AddSurnameEvent extends AddDetailsEvent {
  final String realName;

  AddSurnameEvent({required this.realName});
}

class AddInterestEvent extends AddDetailsEvent {
  final String intrest;

  AddInterestEvent({required this.intrest});
}

class RemoveInterestEvent extends AddDetailsEvent {
  final String intrest;

  RemoveInterestEvent({required this.intrest});
}

class AddUserNameEvent extends AddDetailsEvent {
  final String username;

  AddUserNameEvent({required this.username});
}

class AddImageEvent extends AddDetailsEvent{
  final String image;

  AddImageEvent({required this.image});
}
