abstract class CommunityCreationEvent{}

class CommunityImageTappedEvent extends CommunityCreationEvent{}

class CommunitySwitchTappedEvent extends CommunityCreationEvent{}

class CommunityCreatingEvent extends CommunityCreationEvent{
  final String communityName;
  final String communityDescription;

  CommunityCreatingEvent({required this.communityName, required this.communityDescription});
}