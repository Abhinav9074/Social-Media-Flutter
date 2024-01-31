abstract class CommunitySearchEvent{}

class MyCommunitySearchingEvent extends CommunitySearchEvent{
  final String searchVal;

  MyCommunitySearchingEvent({required this.searchVal});
}

class OtherCommunitySearchingEvent extends CommunitySearchEvent{
  final String searchVal;

  OtherCommunitySearchingEvent({required this.searchVal});
}