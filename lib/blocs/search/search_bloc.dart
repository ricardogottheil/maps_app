import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>((event, emit) {
      emit(state.copyWith(
        displayManualMarker: true,
      ));
    });

    on<OnDisableManualMarkerEvent>((event, emit) {
      emit(state.copyWith(
        displayManualMarker: false,
      ));
    });
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final trafficRespose = await trafficService.getCoordStartToEnd(start, end);

    final geometry = trafficRespose.routes[0].geometry;
    final distance = trafficRespose.routes[0].distance;
    final duration = trafficRespose.routes[0].duration;

    // Decode the polyline.
    final points = decodePolyline(geometry, accuracyExponent: 6);

    final latLngList = points
        .map((point) => LatLng(point[0].toDouble(), point[1].toDouble()))
        .toList();

    return RouteDestination(
      points: latLngList,
      duration: duration,
      distance: distance,
    );
  }
}
