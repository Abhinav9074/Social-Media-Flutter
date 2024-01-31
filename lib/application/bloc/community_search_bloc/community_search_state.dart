abstract class CommunitySearchState {}

class CommunitySearchInitialState extends CommunitySearchState{}

class CommunitySearchedState extends CommunitySearchState{
  final String keyword;

  CommunitySearchedState({required this.keyword});
}

class NoCommunityState extends CommunitySearchState{}