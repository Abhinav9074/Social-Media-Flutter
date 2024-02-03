// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/location_model/location_model.dart';
import 'package:connected/presentation/core/snackbars/common_snackbar.dart';
import 'package:connected/presentation/screens/main_page/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AllSnackBars.commonSnackbar(
          context: mainPageContext,
          title: 'Please Enable The Location',
          content: 'Please Enable The Location',
          bg: Colors.red);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AllSnackBars.commonSnackbar(
            context: mainPageContext,
            title: 'Please Enable The Location',
            content: 'Please Enable The Location',
            bg: Colors.red);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      AllSnackBars.commonSnackbar(
          context: mainPageContext,
          title: 'Please Enable The Location',
          content: 'Please Enable The Location',
          bg: Colors.red);
      return false;
    }
    return true;
  }

  static Future<LocationModel> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (hasPermission) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> place = await placemarkFromCoordinates(position.latitude, position.longitude);
      final data = LocationModel(lattitude: position.latitude, longitude: position.longitude, administrative: place[0].administrativeArea!, locality: place[0].locality!, country: place[0].country!);
      await UserDbFunctions().addLoactionData(data);
      return data;
    }
    return LocationModel(lattitude: 0.0, longitude: 0.0, administrative: '', locality: '', country: '');
  }
}
