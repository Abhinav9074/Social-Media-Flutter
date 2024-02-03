import 'package:connected/application/bloc/profile_switch_bloc/profile_switch_event.dart';
import 'package:connected/application/bloc/profile_switch_bloc/profile_switch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSwitchBloc extends Bloc<ProfileSwitchEvent,ProfileSwitchState>{
  ProfileSwitchBloc():super(ProfileSwitchInitialState()){
    on<ProfileSwitchTapEvent>((event, emit){
      if(event.currentStatus==true){
        emit(ProfileSwitchToggledState(switchValue: false));
      }else{
        emit(ProfileSwitchToggledState(switchValue: true));
      }
    });
  }
}