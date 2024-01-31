import 'package:image_picker/image_picker.dart';

abstract class CreateDiscussionState{}

class CreateDiscussionInitialState extends CreateDiscussionState{}

class ImageSelectedState extends CreateDiscussionState{
  final String image;
  final XFile imageFile;

  ImageSelectedState({required this.image, required this.imageFile});

  
}

class NoImageSelectedState extends CreateDiscussionState{}

class DiscussionUploadingState extends CreateDiscussionState{}

class DiscussionPostedState extends CreateDiscussionState{}

class DiscussionPostingFailedState extends CreateDiscussionState{}