// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromMap(jsonString);

import 'dart:convert';

class PlacesResponse {
  PlacesResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  String type;
  List<String> query;
  List<Feature> features;
  String attribution;

  PlacesResponse copyWith({
    String? type,
    List<String>? query,
    List<Feature>? features,
    String? attribution,
  }) =>
      PlacesResponse(
        type: type ?? this.type,
        query: query ?? this.query,
        features: features ?? this.features,
        attribution: attribution ?? this.attribution,
      );

  factory PlacesResponse.fromJson(String str) =>
      PlacesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.properties,
    required this.textEs,
    required this.placeNameEs,
    required this.text,
    required this.placeName,
    required this.textEn,
    required this.placeNameEn,
    required this.center,
    required this.geometry,
    required this.context,
    required this.language,
  });

  String id;
  String type;
  List<String> placeType;
  Properties properties;
  String textEs;
  String placeNameEs;
  String text;
  String placeName;
  String textEn;
  String placeNameEn;
  List<double> center;
  Geometry geometry;
  List<Context> context;
  String? language;

  Feature copyWith({
    String? id,
    String? type,
    List<String>? placeType,
    Properties? properties,
    String? textEs,
    String? placeNameEs,
    String? text,
    String? placeName,
    String? textEn,
    String? placeNameEn,
    List<double>? center,
    Geometry? geometry,
    List<Context>? context,
    String? language,
  }) =>
      Feature(
        id: id ?? this.id,
        type: type ?? this.type,
        placeType: placeType ?? this.placeType,
        properties: properties ?? this.properties,
        textEs: textEs ?? this.textEs,
        placeNameEs: placeNameEs ?? this.placeNameEs,
        text: text ?? this.text,
        placeName: placeName ?? this.placeName,
        textEn: textEn ?? this.textEn,
        placeNameEn: placeNameEn ?? this.placeNameEn,
        center: center ?? this.center,
        geometry: geometry ?? this.geometry,
        context: context ?? this.context,
        language: language ?? this.language,
      );

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        textEn: json["text_en"],
        placeNameEn: json["place_name_en"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
        language: json["language"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toMap(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "text_en": textEn,
        "place_name_en": placeNameEn,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
        "language": language,
      };
}

class Context {
  Context({
    required this.id,
    required this.textEs,
    required this.text,
    required this.textEn,
    required this.wikidata,
    required this.language,
    required this.shortCode,
  });

  String id;
  String textEs;
  String text;
  String textEn;
  String? wikidata;
  String? language;
  String? shortCode;

  Context copyWith({
    String? id,
    String? textEs,
    String? text,
    String? textEn,
    String? wikidata,
    String? language,
    String? shortCode,
  }) =>
      Context(
        id: id ?? this.id,
        textEs: textEs ?? this.textEs,
        text: text ?? this.text,
        textEn: textEn ?? this.textEn,
        wikidata: wikidata ?? this.wikidata,
        language: language ?? this.language,
        shortCode: shortCode ?? this.shortCode,
      );

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        textEs: json["text_es"],
        text: json["text"],
        textEn: json["text_en"],
        wikidata: json["wikidata"],
        language: json["language"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "text_en": textEn,
        "wikidata": wikidata,
        "language": language,
        "short_code": shortCode,
      };
}

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  List<double> coordinates;
  String type;

  Geometry copyWith({
    List<double>? coordinates,
    String? type,
  }) =>
      Geometry(
        coordinates: coordinates ?? this.coordinates,
        type: type ?? this.type,
      );

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  Properties({
    required this.foursquare,
    required this.landmark,
    required this.category,
    required this.wikidata,
    required this.maki,
    required this.address,
  });

  String? foursquare;
  bool? landmark;
  String? category;
  String? wikidata;
  String? maki;
  String? address;

  Properties copyWith({
    String? foursquare,
    bool? landmark,
    String? category,
    String? wikidata,
    String? maki,
    String? address,
  }) =>
      Properties(
        foursquare: foursquare ?? this.foursquare,
        landmark: landmark ?? this.landmark,
        category: category ?? this.category,
        wikidata: wikidata ?? this.wikidata,
        maki: maki ?? this.maki,
        address: address ?? this.address,
      );

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        category: json["category"],
        wikidata: json["wikidata"],
        maki: json["maki"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "category": category,
        "wikidata": wikidata,
        "maki": maki,
        "address": address,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));

    return reverseMap;
  }
}
