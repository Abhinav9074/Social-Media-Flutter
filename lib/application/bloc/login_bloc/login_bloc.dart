import 'package:connected/application/bloc/login_bloc/login_event.dart';
import 'package:connected/application/bloc/login_bloc/login_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/repository/authentication_repository.dart';
import 'package:connected/domain/shared_prefrences/login_logout/login_logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoggedInEvent>((event, emit) async {
      AuthRepository authRepo = AuthRepository();
      emit(LoginLoadingState());
      final userCred = await authRepo.signInWithGoogle();

      //on successfull authentication
      if (userCred.user != null) {
        //checking whether the user is existing or not
        if (await UserDbFunctions().checkValue(
                dbName: FirebaseConstants.userDb,
                value: userCred.user!.email!,
                field: FirebaseConstants.fieldEmail) ==
            true) {
          if(await UserDbFunctions().blockStatus(userCred.user!.email!)==false){
            //setting login status as true
          await SharedPrefLogin.setLogin();
          //saving the ID of user in shared prefs from firebase
          await SharedPrefLogin.saveId(
              await UserDbFunctions().getId(userCred.user!.email!));
          //saving the ID of user to local variable to use with stream builder withou await
          await UserDbFunctions().saveUserId(await SharedPrefLogin.getUserId());
          emit(UserExistState(
              username: userCred.user!.displayName!,
              email: userCred.user!.email!));
          }else{
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
        emit(LoginFailedState());
      }
    });
  }
}
