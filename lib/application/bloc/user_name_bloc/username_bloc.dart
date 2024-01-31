import 'package:connected/application/bloc/user_name_bloc/username_event.dart';
import 'package:connected/application/bloc/user_name_bloc/username_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameBloc extends Bloc<UserNameEvent, UsernameState> {
  UsernameBloc() : super(UsernameInitialState()) {

    //checking if the usernaem exist or not
    on<UsernameChangeEvent>((event, emit) async {
      emit(UsernameCheckingState());
      if (event.username.isNotEmpty) {
        if (await UserDbFunctions().checkValue(
                value: event.username,
                field: FirebaseConstants.fieldusername,
                dbName: FirebaseConstants.userDb) ==
            true) {
          emit(UsernameExistState());
        } else {
          if(event.username.length<6){
            emit(UsernameMinLengthState());
          }else{
            emit(NewUsernameState());
          }
        }
      } else if(event.username.isEmpty ){
        emit(NoUsernameState());
      }
    });
    on<UserNameResetEvent>((event, emit){
      emit(NoUsernameState());
    });
  }
}
