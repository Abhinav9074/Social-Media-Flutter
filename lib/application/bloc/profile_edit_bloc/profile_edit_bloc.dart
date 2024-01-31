import 'package:connected/application/bloc/profile_edit_bloc/profile_edit_event.dart';
import 'package:connected/application/bloc/profile_edit_bloc/profile_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent,ProfileEditState>{
  ProfileEditBloc() : super(ProfileEditInitialState()){
    on<ProfilePicTapEvent>((event, emit)async{
     final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
     if(imageFile!=null){
      emit(NewProfilePictureState(image: imageFile.path));
     }
    });
  }
}