abstract class CommunityJoinEvent{}

class CommunityJoiningEvent extends CommunityJoinEvent{
  final bool communityType;
  final String communityId;

  CommunityJoiningEvent({required this.communityId,required this.communityType});
}
