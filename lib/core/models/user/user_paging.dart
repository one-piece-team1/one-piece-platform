import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/user/user_by_id_model.dart';

class UserPaging {
  List<UserById> user;
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
    var list = parsedJson['users'] as List;
    List<UserById> userList = list.map((i) => UserById.fromJson(i)).toList();
    return UserPaging(
      user: userList,
      take: parsedJson['take'],
      skip: parsedJson['skip'],
      count: parsedJson['count'],
    );
  }
}
