import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? _positionStreamSubscription;

  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
      (event, emit) => emit(
        state.copyWith(
          followingUser: true,
        ),
      ),
    );

    on<OnStopFollowingUser>(
      (event, emit) => emit(
        state.copyWith(
          followingUser: false,
        ),
      ),
    );

    on<OnNewUserLocationEvent>((event, emit) {
      emit(
        state.copyWith(
          lastKnownLocation: event.location,
          myLocationHistory: [...state.myLocationHistory, event.location],
        ),
      );
    });
  }

  Future getCurrentPosition() async {
    try {
      final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) return;

      final position = await Geolocator.getCurrentPosition();

      if (kDebugMode) {
        print(position);
      }

      add(
        OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void startFollowingUser() async {
    try {
      final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) return;
      add(OnStartFollowingUser());
      _positionStreamSubscription =
          Geolocator.getPositionStream().listen((event) {
        final position = event;

        add(
          OnNewUserLocationEvent(
            LatLng(position.latitude, position.longitude),
          ),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void stopFollowingUser() {
    _positionStreamSubscription?.cancel();
    add(OnStopFollowingUser());
  }

  @override
  Future<void> close() {
    stopFollowingUser();

    return super.close();
  }
}
