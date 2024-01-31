abstract class CommunityPostingEvent{}

class CommunityPostingImagePickEvent extends CommunityPostingEvent{}

class CommunityPostedEvent extends CommunityPostingEvent{
  final String description;
  final String communityId;
  final String image;

  CommunityPostedEvent({required this.description,required this.communityId,required this.image});
}