import 'dart:developer';

import 'package:connected/application/bloc/location_bloc/location_event.dart';
import 'package:connected/application/bloc/location_bloc/location_state.dart';
import 'package:connected/domain/models/location_model/location_model.dart';
import 'package:connected/domain/repository/location_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationBloc extends Bloc<LocationEvent,LocationState>{
  LocationBloc():super(LocationInitailState()){

    on<LocationButtonPressedEvent>((event, emit)async{
      emit(LocationLoadingState());

      final data = await LocationRepository.getCurrentPosition();
      log(data.administrative);
      
        LocationModel value = LocationModel(lattitude: data.lattitude, longitude: data.longitude, administrative: data.administrative, locality: data.locality, country: data.country);
      emit(LocationFetchedState(locationData: value));
    });
  }
}