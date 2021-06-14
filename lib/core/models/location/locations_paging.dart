import 'package:flutter/foundation.dart';

import 'location.dart';

class LocationsPaging {
  List<Location> locations;
  int take;
  int skip;
  int count;

  LocationsPaging({
    @required this.locations,
    @required this.take,
    @required this.skip,
    @required this.count,
  });

  factory LocationsPaging.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['locations'] as List;
    List<Location> locationList =
        list.map((i) => Location.fromJson(i)).toList();
    return LocationsPaging(
      locations: locationList,
      take: parsedJson['take'],
      skip: parsedJson['skip'],
      count: parsedJson['count'],
    );
  }
}
