import 'package:connected/application/bloc/user_search_bloc/user_search_event.dart';
import 'package:connected/application/bloc/user_search_bloc/user_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSearchBloc extends Bloc<UserSearchEvent,UserSearchState>{
  UserSearchBloc() :super(UserSearchInitialState()){
    on<UserSearchingEvent>((event, emit){
      emit(UserResultState(searchValue: event.searchValue));
    });

    on<NoSearchValueEvent>((event, emit) => emit(NoSearchValueState()));
  }
}