abstract class OtherProfileEvent{}

class OtherProfileRedirectEvent extends OtherProfileEvent{
  final String otherUserId;

  OtherProfileRedirectEvent({required this.otherUserId});
}

class FollowUserEvent extends OtherProfileEvent{
  final String followedUserId;

  FollowUserEvent({required this.followedUserId});
}

class UnfollowUserEvent extends OtherProfileEvent{
  final String unfollowUserId;

  UnfollowUserEvent({required this.unfollowUserId});
}

