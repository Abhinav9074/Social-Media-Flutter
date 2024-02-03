import 'package:connected/domain/models/location_model/location_model.dart';

abstract class LocationState{}

class LocationInitailState extends LocationState{}

class LocationLoadingState extends LocationState{}

class LocationFetchedState extends LocationState{
  final LocationModel locationData;

  LocationFetchedState({required this.locationData});
  
}
