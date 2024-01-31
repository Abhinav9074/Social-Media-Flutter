import 'dart:developer';
import 'dart:io';

import 'package:connected/application/bloc/community_creation_bloc/community_creation_event.dart';
import 'package:connected/application/bloc/community_creation_bloc/community_creation_state.dart';
import 'package:connected/domain/fire_store_functions/community_db/community_db_functions.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/community_model/community_model.dart';
import 'package:connected/domain/repository/file_upload_repository.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CommunityCreationBloc
    extends Bloc<CommunityCreationEvent, CommunityCreationState> {
  CommunityCreationBloc() : super(CommunityCreationInitialState()) {
    bool switchval = false;
    String pickImage = '';

    //handles the profile of community state
    on<CommunityImageTappedEvent>((event, emit) async {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickImage = image.path;
        emit(CommunityImagePickedState(image: image.path, val: switchval));
      }
    });

    //handles the switch state
    on<CommunitySwitchTappedEvent>((event, emit) {
      if (switchval == false) {
        switchval = true;
        emit(CommunitySwitchState(val: switchval, image: pickImage));
      } else {
        switchval = false;
        emit(CommunitySwitchState(val: switchval, image: pickImage));
      }
    });

    //handles the community creation
    on<CommunityCreatingEvent>((event, emit) async {
      emit(CommunityCreatingState());
      AllSnackBars.commonSnackbar(context: mainPageContext, title: 'Creating Community...', content: 'Creating Community...', bg: Colors.black);
      final upload = FileUploadRepository();
      String? imgUrl = await upload.uploadImage(File(pickImage));
      final data = CommunityModel(
          name: event.communityName,
          description: event.communityDescription,
          image: imgUrl!,
          adminId: UserDbFunctions().userId,
          communityPosts: [],
          createdTime: DateTime.now(),
          private: switchval,
          members: [UserDbFunctions().userId],
          communityNotifications: [],
          requests: [],
          typing: ''
          );

      await CommunityDbFunctions().createCommunity(data);
      emit(CommunityCreatedState());
    });
  }
}
