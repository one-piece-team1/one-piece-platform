import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/trip/trip.dart';

class TripPaging {
  List<Trip> trips;
  int take;
  int skip;
  int count;

  TripPaging({
    @required this.trips,
    @required this.take,
    @required this.skip,
    @required this.count,
  });

  factory TripPaging.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['trips'] as List;
    List<Trip> tripList = list.map((i) => Trip.fromJson(i)).toList();
    return TripPaging(
      trips: tripList,
      take: parsedJson['take'],
      skip: parsedJson['skip'],
      count: parsedJson['count'],
    );
  }
}
