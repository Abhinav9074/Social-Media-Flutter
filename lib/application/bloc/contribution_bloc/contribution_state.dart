import 'package:image_picker/image_picker.dart';

abstract class ContributionState{}

class ContributionInitialState extends ContributionState{}

class ImageSelectedState extends ContributionState{
  final String image;
  final XFile imageFile;

  ImageSelectedState({required this.image, required this.imageFile});

  
}

class NoImageSelectedState extends ContributionState{}

class ContributionUploadingState extends ContributionState{}

class ContributionPostedState extends ContributionState{}