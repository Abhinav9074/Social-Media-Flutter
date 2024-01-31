// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_event.dart';
import 'package:connected/application/bloc/create_discussion_bloc/create_discussion_state.dart';
import 'package:connected/domain/fire_store_functions/discussion_db/discussion_db_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/dicsussion_model/discussion_model.dart';
import 'package:connected/domain/repository/file_upload_repository.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateDiscussionBloc
    extends Bloc<CreateDiscussionEvent, CreateDiscussionState> {
  CreateDiscussionBloc() : super(CreateDiscussionInitialState()) {
    on<OnImagePickedEvent>((event, emit) async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(ImageSelectedState(image: image.path, imageFile: image));
      } else {
        emit(NoImageSelectedState());
      }
    });


    on<DiscussionCreateEvent>((event, emit) async {
      AllSnackBars.commonSnackbar(
          context: mainPageContext,
          title: 'Posting',
          content: 'Uploading Post',
          bg: const Color.fromARGB(255, 50, 51, 50));
      emit(DiscussionUploadingState());
      final FileUploadRepository upload = FileUploadRepository();

      String? img = '';
      if (event.imageFile.isNotEmpty) {
        img = await upload.uploadImage(File(event.imageFile));
      }
      final data = DiscussionModel(
          title: event.title,
          image: img!,
          description: event.description,
          likes: [],
          disLikes: [],
          contributions: [],
          edited: false,
          tags: [],
          userId: UserDbFunctions().userId,
          time: DateTime.now());
      try {
        emit(DiscussionPostedState());
        await DiscussionDbFunctions().addDiscussion(data);
        emit(DiscussionPostedState());
      } catch (e) {
        emit(DiscussionPostingFailedState());
      }
    });

    on<DiscussionEditEvent>((event, emit) async {
      AllSnackBars.commonSnackbar(
          context: mainPageContext,
          title: 'Posting',
          content: 'Updating Post',
          bg: const Color.fromARGB(255, 50, 51, 50));
      emit(DiscussionUploadingState());
      final FileUploadRepository upload = FileUploadRepository();
      String? img = '';
      if (event.imageFile.isNotEmpty) {
        img = await upload.uploadImage(File(event.imageFile));
      }else{
        img=event.imageFile;
      }
      final data = DiscussionModel(
          title: event.title,
          image: img!,
          description: event.description,
          likes: [],
          disLikes: [],
          contributions: [],
          edited: false,
          tags: [],
          userId: UserDbFunctions().userId,
          time: DateTime.now());
      try {
        emit(DiscussionPostedState());
        await DiscussionDbFunctions().editDiscussion(data,event.discussionId);
        emit(DiscussionPostedState());
      } catch (e) {
        emit(DiscussionPostingFailedState());
      }
    });
  }
}
