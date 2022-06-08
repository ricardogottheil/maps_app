import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoicmljYXJkb2dvdHRoZWlsIiwiYSI6ImNqaDBvNnd0ZDE5dDIzMmxlMTc0ZHk0OTIifQ.mn5Js1PJ3coi_aI9ygrWdA';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'limit': 7,
      'language': 'en,es',
      'access_token': accessToken,
    });

    super.onRequest(options, handler);
  }
}
