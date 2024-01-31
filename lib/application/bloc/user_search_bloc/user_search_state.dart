abstract class UserSearchState{}

class UserSearchInitialState extends UserSearchState{}

class UserResultState extends UserSearchState{
  final String searchValue;

  UserResultState({required this.searchValue});
}

class NoSearchValueState extends UserSearchState{}