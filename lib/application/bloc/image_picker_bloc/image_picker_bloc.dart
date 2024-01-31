
import 'dart:io';

import 'package:connected/application/bloc/image_picker_bloc/image_picker_event.dart';
import 'package:connected/application/bloc/image_picker_bloc/image_picker_state.dart';
import 'package:connected/domain/repository/file_upload_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent,ImagePickerState>{
  XFile? image;
  ImagePickerBloc() : super(ImagePickerInitialState()){
    FileUploadRepository upload = FileUploadRepository();
    on<ImagePickedEvent>((event, emit)async{
       image = await ImagePicker().pickImage(source: ImageSource.gallery);
       if(image!=null){
        emit(ImagePickedState(image: image!));
       }
    });

    on<ImageUploadEvent>((event, emit)async{
      emit(ImageUploadingState(image: image!));
      String? img =await upload.uploadImage(File(image!.path));
      emit(ImageUploadedState(image: img!));
    });
  }
}