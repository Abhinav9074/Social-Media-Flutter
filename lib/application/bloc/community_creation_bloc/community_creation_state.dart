abstract class CommunityCreationState{}

class CommunityCreationInitialState extends CommunityCreationState{}

class CommunityImagePickedState extends CommunityCreationState{
  final String image;
  final bool val;

  CommunityImagePickedState({required this.image,required this.val});
}

class CommunitySwitchState extends CommunityCreationState{
  final bool val;
  final String image;

  CommunitySwitchState({required this.val, required this.image});
}

class  CommunityCreatingState extends CommunityCreationState{
}

class CommunityCreatedState extends CommunityCreationState{}



