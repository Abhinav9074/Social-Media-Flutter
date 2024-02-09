import 'dart:developer';

import 'package:connected/application/bloc/other_profile_bloc/other_profile_event.dart';
import 'package:connected/application/bloc/other_profile_bloc/other_profile_state.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherProfileBloc extends Bloc<OtherProfileEvent,OtherProfileState>{
  OtherProfileBloc() : super(OtherProfileInitialState()){
    on<OtherProfileRedirectEvent>((event, emit)async{
      emit(OtherProfileLoadingState());
      if(await UserDbFunctions().isFollowingState(event.otherUserId)){
        emit(FollowingState());
      }else if(await UserDbFunctions().isFollowBackState(event.otherUserId)){
        emit(FollowBackState());
      }else{
        log('done');
        emit(NotFollowingState());
      }
    });

    on<UnfollowUserEvent>((event, emit)async{
      emit(OtherProfileLoadingState());
      await UserDbFunctions().unFollowUser(event.unfollowUserId);
      if(await UserDbFunctions().isFollowBackState(event.unfollowUserId)){
        emit(FollowBackState());
      }else{
        emit(NotFollowingState());
      }
    });

    on<FollowUserEvent>((event, emit)async{
      emit(OtherProfileLoadingState());
      await UserDbFunctions().followUser(event.followedUserId);
        emit(FollowingState());
    });
  }
}