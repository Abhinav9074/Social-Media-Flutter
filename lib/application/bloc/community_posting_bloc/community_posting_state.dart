abstract class CommunityPostingState{}

class CommunityPostingInitialState extends CommunityPostingState{}

class CommunityPostingImagePickedState extends CommunityPostingState{
  final String image;

  CommunityPostingImagePickedState({required this.image});
}

class CommunityPostingNoImageState extends CommunityPostingState{}

class CommunityPostingGoBackImageState extends CommunityPostingState{}

class CommunityPostSubmittedState extends CommunityPostingState{}