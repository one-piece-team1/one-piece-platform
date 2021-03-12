import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/user/user_by_id_model.dart';

class UserPaging {
  UserById user;
  int take;
  int skip;
  int count;

  UserPaging({
    @required this.user,
    @required this.take,
    @required this.skip,
    @required this.count,
  });

  factory UserPaging.fromJson(Map<String, dynamic> parsedJson) {
    return UserPaging(
      user: UserById.fromJson(
        parsedJson['users'],
      ),
      take: parsedJson['take'],
      skip: parsedJson['skip'],
      count: parsedJson['count'],
    );
  }
}
