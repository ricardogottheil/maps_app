import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    on<OnStartFollowingUserEvent>(_onStartFollowingUser);

    on<OnStopFollowingUserEvent>(((event, emit) {
      emit(state.copyWith(isFollowingUser: false));
    }));

    on<UpdateUserPolylinesEvent>(_onPolylineNewPoint);

    on<OnToggleUserRoute>((event, emit) {
      emit(state.copyWith(showMyRoute: !state.showMyRoute));
    });

    on<DisplayPolylinesEvent>(((event, emit) {
      emit(state.copyWith(polylines: event.polylines, markers: event.markers));
    }));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylinesEvent(locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController?.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng position) {
    final cameraUpdate = CameraUpdate.newLatLng(position);

    _mapController?.animateCamera(cameraUpdate);
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylinesEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userHistory,
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: destination.points,
    );

    double kms = destination.duration / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    double tripDuration = (destination.duration / 60).floorToDouble();

    /*final iconStartMarker = await getAssetImageMarker();
    final iconEndMarker = await getNetworkImageMarker();*/

    final iconStartMarker =
        await getStartCustomMarker(tripDuration.toInt(), 'My location');

    final iconEndMarker =
        await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: iconStartMarker,
      anchor: const Offset(0.08, 1),
      /*infoWindow: InfoWindow(
        title: 'Inicio',
        snippet: 'KM: $kms, duración: $tripDuration',
      ),*/
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: iconEndMarker,
      /*infoWindow: InfoWindow(
        title: destination.endPlace.text,
        snippet: destination.endPlace.placeName,
      ),*/
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = polyline;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(DisplayPolylinesEvent(currentPolylines, currentMarkers));

    await Future.delayed(const Duration(milliseconds: 300));
    _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
