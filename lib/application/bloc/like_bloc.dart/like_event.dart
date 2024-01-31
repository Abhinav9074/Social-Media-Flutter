abstract class LikeEvent {}

class AddLikeEvent extends LikeEvent{
  final String discussionId;

  AddLikeEvent({required this.discussionId});
}

class RemoveLikeEvent extends LikeEvent{
  final String discussionId;

  RemoveLikeEvent({required this.discussionId});
}

class CheckLikeEvent extends LikeEvent{
  final String discussionId;

  CheckLikeEvent({required this.discussionId});
}


