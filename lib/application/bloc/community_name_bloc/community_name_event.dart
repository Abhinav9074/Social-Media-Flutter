abstract class CommunityNameEvent{}

class CommunityNameChangeEvent extends CommunityNameEvent{
  final String communityName;

  CommunityNameChangeEvent({required this.communityName});
  
}

class CommunityNameResetEvent extends CommunityNameEvent{}