import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_event.dart';
import 'package:connected/application/bloc/user_access_bloc/user_access_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccessBloc extends Bloc<UserAccessEvent, UserAccessState> {
  UserAccessBloc() : super(UserAccessInitialState()) {
    on<CheckUserAccess>((event, emit) async {
      log('called checking');
      final data = await FirebaseFirestore.instance
          .collection(FirebaseConstants.userDb)
          .doc(UserDbFunctions().userId)
          .get();
      if (data[FirebaseConstants.fieldUserBlocked] == true) {
        emit(UserBlockedState());
      }
    });
  }
}
