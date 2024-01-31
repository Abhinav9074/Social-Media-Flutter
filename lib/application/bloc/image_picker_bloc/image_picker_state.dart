
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerState{}

class ImagePickerInitialState extends ImagePickerState{}

class ImagePickedState extends ImagePickerState{
  final XFile image;

  ImagePickedState({required this.image});
  
}

class ImageUploadedState extends ImagePickerState{
  final String image ;

  ImageUploadedState({required this.image});
}

class ImageUploadingState extends ImagePickerState{
   final XFile image;

  ImageUploadingState({required this.image});
}
