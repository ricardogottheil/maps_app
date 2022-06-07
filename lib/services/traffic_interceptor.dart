import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoicmljYXJkb2dvdHRoZWlsIiwiYSI6ImNqaDBvNnd0ZDE5dDIzMmxlMTc0ZHk0OTIifQ.mn5Js1PJ3coi_aI9ygrWdA';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });
    super.onRequest(options, handler);
  }
}
