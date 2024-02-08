import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_event.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_state.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/user_model/user_model.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDetailsBloc extends Bloc<AddDetailsEvent, AddDetailsState> {
  String realName = '';
  String username = '';
  List<String> interests = [];
  String image = '';
  AddDetailsBloc() : super(AddDetailsInitialState()) {
    on<AddSurnameEvent>((event, emit) {
      realName = event.realName;
    });

    on<AddInterestEvent>((event, emit) {
      interests.add(event.intrest);
      interests = interests.toSet().toList();
      emit(InterestUpdatedState(interests: interests));
    });

    on<RemoveInterestEvent>((event, emit) {
      interests.remove(event.intrest);
      interests = interests.toSet().toList();
      emit(InterestUpdatedState(interests: interests));
    });

    on<AddUserNameEvent>((event, emit) {
      username = event.username;
    });

    on<AddImageEvent>((event, emit) async {
      final data = UserModel(
          realName: realName,
          username: username,
          email: await SharedPrefLogin.getEmail(),
          image: event.image,
          interest: interests,
          following: [],
          followers: [],
          discussions: [],
          liked: [],
          notifications:[],
          location: '',
          gender: '',
          locationStr: '',
          createdTime: DateTime.now(),
          communities: [],
          requestedCommunities: [],
          communitiyNames: [],
          blocked: false,
          locationView: false,
          lattitude: 0.0,
          longitude: 0.0,
          address: '',
          bio: '',
          premium: false,
          notificationCount: 0,
          chat: [],
          savedDiscussion: []
          );

      //adding a user to firebase
      await UserDbFunctions().addUser(data);

      //clearing all the temp fields
      interests.clear();
      realName = '';
      username = '';

      //saving the user id in shared prefs for future access
      await SharedPrefLogin.saveId(await UserDbFunctions().getId(
        await SharedPrefLogin.getEmail(),
      ));

      //saving user id locally to acces faster
      await UserDbFunctions().saveUserId(await SharedPrefLogin.getUserId());
    });
  }
}
