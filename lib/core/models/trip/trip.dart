import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/common/base.dart';
import 'package:one_piece_platform/core/models/enums/trip.dart';
import 'package:one_piece_platform/core/models/location/location.dart';
import 'package:one_piece_platform/core/models/post/post.dart';
import 'package:one_piece_platform/core/models/user/user_by_id_model.dart';
import 'package:one_piece_platform/core/models/user/user_model.dart';

import 'multi_line_string.dart';

class Trip extends Base {
  String id;
  DateTime startDate;
  DateTime endDate;
  ETripView publicStatus;
  String companyName; //
  String shipNumber; //
  MultiLineString geom; //
  User publisher;
  List<UserById> viewers;
  List<Post> posts;
  Location startPoint;
  Location endPoint;

  Trip({
    @required this.id,
    @required this.startDate,
    @required this.endDate,
    @required this.publicStatus,
    this.companyName,
    this.shipNumber,
    this.geom,
    @required this.publisher,
    @required this.viewers,
    @required this.posts,
    @required this.startPoint,
    @required this.endPoint,
  });

  factory Trip.fromJson(Map<String, dynamic> parsedJson) {
    var userList = parsedJson['viewers'] as List;

    List<UserById> userListFromJson =
        userList.map((i) => UserById.fromJson(i)).toList();
    var postList = parsedJson['posts'] as List;

    List<Post> postListFromJson =
        postList.map((i) => Post.fromJson(i)).toList();
    return Trip(
      id: parsedJson['id'],
      startDate: parsedJson['startDate'],
      endDate: parsedJson['endDate'],
      publicStatus: parsedJson['publicStatus'],
      publisher: parsedJson['publisher'],
      viewers: userListFromJson,
      posts: postListFromJson,
      startPoint: parsedJson['startPoint'],
      endPoint: parsedJson['endPoint'],
    );
  }
}
