import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/common/base.dart';
import 'package:one_piece_platform/core/models/enums/location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'country.dart';
import 'point.dart';
//part 'location.g.dart';

//@JsonSerializable()
class Location extends Base {
  final String id;
  final Point point;
  final Point pointSrid;
  final double lat;
  final double lon;
  final ELocationType type;
  final String locationName;
  final Country country;

  Location({
    this.id,
    this.point,
    this.pointSrid,
    this.lat,
    this.lon,
    this.type,
    this.locationName,
    this.country,
  });

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    return Location(
      id: parsedJson['id'],
      point: parsedJson['point'],
      pointSrid: parsedJson['pointSrid'],
      lat: parsedJson['lat'],
      lon: parsedJson['lon'],
      type: parsedJson['type'],
      locationName: parsedJson['locationName'],
      country: parsedJson['country'],
    );
  }
}
