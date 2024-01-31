import 'dart:async';

import 'package:connected/application/bloc/splash_bloc/splash_event.dart';
import 'package:connected/application/bloc/splash_bloc/splash_state.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashBloc extends Bloc<SplashEvent,SplashState>{
  SplashBloc() : super(SplashInitialState()){

    Timer(const Duration(seconds: 5), () {
      add(SplashLoadedEvent());
    });

    on<SplashLoadedEvent>((event, emit)  async{
      if(await SharedPrefLogin.checkLogin()==true){
        await UserDbFunctions().saveUserId(await SharedPrefLogin.getUserId());
        emit(SplashLoggedInState());
      }else{
        await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
        emit(SplashLoadedState());
      }
    });
  }
}