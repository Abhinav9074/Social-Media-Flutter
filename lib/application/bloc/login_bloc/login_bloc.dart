import 'dart:developer';
import 'dart:io';

import 'package:connected/application/bloc/login_bloc/login_event.dart';
import 'package:connected/application/bloc/login_bloc/login_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/repository/authentication_repository.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoggedInEvent>((event, emit) async {
      emit(LoginLoadingState());
      //checking internet availability
      try {
        dynamic net;
        if(!kIsWeb){
          final result = await InternetAddress.lookup('example.com');
          net = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        }else{
          net = true;
        }
        
        if (net==true) {
          AuthRepository authRepo = AuthRepository();
          emit(LoginLoadingState());
          try {
            final userCred = await authRepo.signInWithGoogle();

            //on successfull authentication
            if (userCred.user != null) {
              //checking whether the user is existing or not
              if (await UserDbFunctions().checkValue(
                      dbName: FirebaseConstants.userDb,
                      value: userCred.user!.email!,
                      field: FirebaseConstants.fieldEmail) ==
                  true) {
                if (await UserDbFunctions()
                        .blockStatus(userCred.user!.email!) ==
                    false) {
                  //setting login status as true
                  await SharedPrefLogin.setLogin();
                  //saving the ID of user in shared prefs from firebase
                  await SharedPrefLogin.saveId(
                      await UserDbFunctions().getId(userCred.user!.email!));
                  //saving the ID of user to local variable to use with stream builder withou await
                  await UserDbFunctions()
                      .saveUserId(await SharedPrefLogin.getUserId());
                  emit(UserExistState(
                      username: userCred.user!.displayName!,
                      email: userCred.user!.email!));
                } else {
                  emit(UserBlockedState());
                }

                //new user case
              } else {
                //saving the email of new user for adding to firebase at the end of accnt creation
                await SharedPrefLogin.saveEmail(userCred.user!.email!);
                emit(NewUserState(
                    username: userCred.user!.displayName!,
                    email: userCred.user!.email!));
              }
            } else {
              log('ivde aan error');
              emit(LoginFailedState());
            }
          } catch (e) {
            log(e.toString());
            emit(LoginFailedState());
          }
        }
      } on SocketException catch (_) {
        emit(NoInternetState());
      }
    });

    //ON MANUAL LOGIN
    on<ManualLoginEvent>((event, emit) async {
      emit(ManualLoginLoadingState());

      //checking internet availability
      try {
       dynamic net;
        if(!kIsWeb){
          final result = await InternetAddress.lookup('example.com');
          net = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        }else{
          net = true;
        }
        
        if (net==true) {
          try {
            //checking whether the user is existing or not
            if (await UserDbFunctions().checkValue(
                        dbName: FirebaseConstants.userDb,
                        value: event.email,
                        field: FirebaseConstants.fieldEmail) ==
                    true &&
                await UserDbFunctions()
                    .checkPassword(event.email, event.password)) {
              if (await UserDbFunctions().blockStatus(event.email) == false) {
                //setting login status as true
                await SharedPrefLogin.setLogin();
                //saving the ID of user in shared prefs from firebase
                await SharedPrefLogin.saveId(
                    await UserDbFunctions().getId(event.email));
                //saving the ID of user to local variable to use with stream builder withou await
                await UserDbFunctions()
                    .saveUserId(await SharedPrefLogin.getUserId());
                emit(UserExistState(username: event.email, email: event.email));
              } else {
                emit(UserBlockedState());
              }

              //USER DONT EXIST
            } else {
              emit(NoUserState());
            }
          } catch (e) {
            log('alla ivde ivde ${e.toString()}');
            emit(LoginFailedState());
          }
        }
      } on SocketException catch (_) {
        emit(NoInternetState());
      }
    });

    //MANUAL SIGNUP EVENT
    on<ManualSignUpEvent>((event, emit)async{
      log('keruuuuu');
      emit(ManualLoginLoadingState());

      //checking internet availability
      try {
       dynamic net;
        if(!kIsWeb){
          final result = await InternetAddress.lookup('example.com');
          net = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        }else{
          net = true;
        }
        
        if (net==true) {
          try {
            //checking whether the user is existing or not
            if (await UserDbFunctions().checkValue(
                        dbName: FirebaseConstants.userDb,
                        value: event.email,
                        field: FirebaseConstants.fieldEmail) ==
                    false) {
                //saving the email of new user for adding to firebase at the end of accnt creation
                await SharedPrefLogin.saveEmail(event.email);
                emit(NewUserState(
                    username: event.email,
                    email: event.email));

              //new user case
            } else {
              emit(NoUserState());
            }
          } catch (e) {
            log('Ivde ivde ${e.toString()}');
            emit(LoginFailedState());
          }
        }
      } on SocketException catch (_) {
        emit(NoInternetState());
      }

    });
  }
}
