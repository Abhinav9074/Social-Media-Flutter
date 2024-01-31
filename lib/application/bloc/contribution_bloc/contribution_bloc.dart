import 'dart:io';

import 'package:connected/application/bloc/contribution_bloc/contribution_event.dart';
import 'package:connected/application/bloc/contribution_bloc/contribution_state.dart';
import 'package:connected/domain/fire_store_functions/contribution_db/contribution_db.dart';
import 'package:connected/domain/models/contribution_model/contribution_model.dart';
import 'package:connected/domain/repository/file_upload_repository.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ContributionBloc extends Bloc<ContributionEvent, ContributionState> {
  ContributionBloc() : super(ContributionInitialState()) {
    on<OnImagePickedEvent>((event, emit) async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(ImageSelectedState(image: image.path, imageFile: image));
      } else {
        emit(NoImageSelectedState());
      }
    });

    on<ContributionCreateEvent>((event, emit) async {
      AllSnackBars.commonSnackbar(context: mainPageContext, title: 'Uploading', content: 'Posting...', bg: const Color.fromARGB(255, 95, 92, 92));
      emit(ContributionUploadingState());
      String? img='';
      if (event.imageFile.isNotEmpty) {
        final FileUploadRepository upload = FileUploadRepository();
        img = await upload.uploadImage(File(event.imageFile));
      }
      final data = ContributionModel(
          description: event.description,
          image: img!,
          contributer: await SharedPrefLogin.getUserId(),
          discssionId: event.discussionId,
          time: DateTime.now());
      await ContributionDbFunctions().addContribution(data);
      emit(ContributionPostedState());
    });
  }
}
