abstract class ProfileEditState{}

class ProfileEditInitialState extends ProfileEditState{}

class OldProfilePictureState extends ProfileEditState{
  final String image;

  OldProfilePictureState({required this.image});
}

class NewProfilePictureState extends ProfileEditState{
  final String image;

  NewProfilePictureState({required this.image});
}