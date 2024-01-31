class FirebaseConstants{

  //All important names in firebase DB


  //db names
  static const String userDb = 'user';
  static const String discussionDb = 'discussions';
  static const String contributionDb = 'contribution';
  static const String interestsDb = 'interest';
  static const String communityDb = 'community';
  static const String communityPostDb = 'community_posts';

  //interest db id
  static const String interestDbId = 'IJ6hEiz0OVdo7AfhXvg4';


  // user db fields
  static const String fieldEmail = 'email';
  static const String fieldusername = 'username';
  static const String fieldImage = 'image';
  static const String fieldInterest = 'interest';
  static const String fieldRealname = 'realname';
  static const String fieldFollowing = 'following';
  static const String fieldFollowers = 'followers';
  static const String fieldDiscussions = 'discussions';
  static const String fieldLiked = 'liked';
  static const String filedDisliked = 'disliked';
  static const String filedGender = 'gender';
  static const String filedLocationStr = 'location_str';
  static const String filedLocation = 'location';
  static const String filedCreatedTime = 'created_time';
  static const String filedPhone = 'phone';
  static const String fieldCommunities = 'communities';
  static const String fieldRequestedCommunities = 'requestedCommunities';
  static const String fieldCommunitiyNames = 'communityNames';


  //discussion db fields
  static const String fieldDiscussionTitle = 'title';
  static const String fieldDiscussionImage = 'image';
  static const String fieldDiscussionDescription = 'description';
  static const String fieldDiscussionLikes = 'likes';
  static const String fieldDiscussionDisLikes = 'disLikes';
  static const String fieldDiscussionContribution = 'contributions';
  static const String fieldDiscussionEdited = 'edited';
  static const String fieldDiscussionTags = 'tags';
  static const String fieldDiscussionUserId = 'userId';
  static const String fieldDiscussionContributer = 'contributer';
  static const String fieldDiscussionDiscussionId = 'discussionId';
  static const String fieldDiscussionCreatedTime = 'createdTime';

  //contribution db fields
  static const String fieldContributionDescription = 'description';
  static const String fieldContributer = 'contributer';
  static const String fieldContributedTime = 'createdTime';


  //interest db fields
  static const String fieldInterests = 'interests';

  //community db fields
  static const String fieldCommunityName = 'communityName';
  static const String fieldCommunityDescription = 'communityDescription';
  static const String fieldCommunityProfile = 'communityProfile';
  static const String fieldCommunityAdminId = 'communityAdmin';
  static const String fieldCommunityPosts = 'communityPosts';
  static const String fieldCommunityCreatedTime = 'communityCreatedTime';
  static const String fieldCommunityPrivate = 'private';
  static const String fieldCommunityMembers = 'communityMembers';
  static const String fieldCommunityNotifications = 'communityNotifications';
  static const String fieldCommunityRequests = 'communityRequests';
  static const String fieldCommunityTyping = 'typing';

  //community post fields
  static const String fieldCommunityPostMessage = 'message';
  static const String fieldCommunityPostIsAltert = 'alert';
  static const String fieldCommunityPostAlertMsg = 'alertMsg';
  static const String fieldCommunityPostImage = 'image';
  static const String fieldCommunityId = 'communityId';
  static const String fieldCommunityPostUserId = 'userId';
  static const String fieldCommunityPostTime = 'time';


}