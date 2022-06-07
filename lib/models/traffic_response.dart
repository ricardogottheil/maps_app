// To parse this JSON data, do
//
//     final trafficResponse = trafficResponseFromMap(jsonString);

import 'dart:convert';

class TrafficResponse {
  TrafficResponse({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  List<Route> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  TrafficResponse copyWith({
    List<Route>? routes,
    List<Waypoint>? waypoints,
    String? code,
    String? uuid,
  }) =>
      TrafficResponse(
        routes: routes ?? this.routes,
        waypoints: waypoints ?? this.waypoints,
        code: code ?? this.code,
        uuid: uuid ?? this.uuid,
      );

  factory TrafficResponse.fromJson(String str) =>
      TrafficResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrafficResponse.fromMap(Map<String, dynamic> json) => TrafficResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
        waypoints: List<Waypoint>.from(
            json["waypoints"].map((x) => Waypoint.fromMap(x))),
        code: json["code"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toMap() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toMap())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toMap())),
        "code": code,
        "uuid": uuid,
      };
}

class Route {
  Route({
    required this.countryCrossed,
    required this.weightTypical,
    required this.durationTypical,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry,
  });

  bool countryCrossed;
  double weightTypical;
  double durationTypical;
  String weightName;
  double weight;
  double duration;
  double distance;
  List<Leg> legs;
  String geometry;

  Route copyWith({
    bool? countryCrossed,
    double? weightTypical,
    double? durationTypical,
    String? weightName,
    double? weight,
    double? duration,
    double? distance,
    List<Leg>? legs,
    String? geometry,
  }) =>
      Route(
        countryCrossed: countryCrossed ?? this.countryCrossed,
        weightTypical: weightTypical ?? this.weightTypical,
        durationTypical: durationTypical ?? this.durationTypical,
        weightName: weightName ?? this.weightName,
        weight: weight ?? this.weight,
        duration: duration ?? this.duration,
        distance: distance ?? this.distance,
        legs: legs ?? this.legs,
        geometry: geometry ?? this.geometry,
      );

  factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Route.fromMap(Map<String, dynamic> json) => Route(
        countryCrossed: json["country_crossed"],
        weightTypical: json["weight_typical"].toDouble(),
        durationTypical: json["duration_typical"].toDouble(),
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
        geometry: json["geometry"],
      );

  Map<String, dynamic> toMap() => {
        "country_crossed": countryCrossed,
        "weight_typical": weightTypical,
        "duration_typical": durationTypical,
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toMap())),
        "geometry": geometry,
      };
}

class Leg {
  Leg({
    required this.viaWaypoints,
    required this.admins,
    required this.weightTypical,
    required this.durationTypical,
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  List<dynamic> viaWaypoints;
  List<Admin> admins;
  double weightTypical;
  double durationTypical;
  double weight;
  double duration;
  List<dynamic> steps;
  double distance;
  String summary;

  Leg copyWith({
    List<dynamic>? viaWaypoints,
    List<Admin>? admins,
    double? weightTypical,
    double? durationTypical,
    double? weight,
    double? duration,
    List<dynamic>? steps,
    double? distance,
    String? summary,
  }) =>
      Leg(
        viaWaypoints: viaWaypoints ?? this.viaWaypoints,
        admins: admins ?? this.admins,
        weightTypical: weightTypical ?? this.weightTypical,
        durationTypical: durationTypical ?? this.durationTypical,
        weight: weight ?? this.weight,
        duration: duration ?? this.duration,
        steps: steps ?? this.steps,
        distance: distance ?? this.distance,
        summary: summary ?? this.summary,
      );

  factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromMap(x))),
        weightTypical: json["weight_typical"].toDouble(),
        durationTypical: json["duration_typical"].toDouble(),
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        distance: json["distance"].toDouble(),
        summary: json["summary"],
      );

  Map<String, dynamic> toMap() => {
        "via_waypoints": List<dynamic>.from(viaWaypoints.map((x) => x)),
        "admins": List<dynamic>.from(admins.map((x) => x.toMap())),
        "weight_typical": weightTypical,
        "duration_typical": durationTypical,
        "weight": weight,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "distance": distance,
        "summary": summary,
      };
}

class Admin {
  Admin({
    required this.iso31661Alpha3,
    required this.iso31661,
  });

  String iso31661Alpha3;
  String iso31661;

  Admin copyWith({
    String? iso31661Alpha3,
    String? iso31661,
  }) =>
      Admin(
        iso31661Alpha3: iso31661Alpha3 ?? this.iso31661Alpha3,
        iso31661: iso31661 ?? this.iso31661,
      );

  factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
      };
}

class Waypoint {
  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  double distance;
  String name;
  List<double> location;

  Waypoint copyWith({
    double? distance,
    String? name,
    List<double>? location,
  }) =>
      Waypoint(
        distance: distance ?? this.distance,
        name: name ?? this.name,
        location: location ?? this.location,
      );

  factory Waypoint.fromJson(String str) => Waypoint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Waypoint.fromMap(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
      };
}
