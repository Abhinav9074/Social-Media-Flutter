abstract class UserSearchEvent{}

class UserSearchingEvent extends UserSearchEvent{
  final String searchValue;

  UserSearchingEvent({required this.searchValue});
}

class NoSearchValueEvent extends UserSearchEvent{}
