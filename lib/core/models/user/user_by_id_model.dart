import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/common/base.dart';

class UserById extends Base {
  String id;
  String role;
  int diamondCoin;
  int goldCoin;
  String username;
  String email;
  bool status;
  String gender;
  int age;
  String desc;
  String profileImage;
//  List trips;
//  List views;
//  List posts;
//  List likePosts;
//  List followers;
//  List following;
//  List blockLists;
  int followerCount;
  int followingCount;

  UserById({
    @required this.id,
    @required this.role,
    @required this.diamondCoin,
    @required this.goldCoin,
    @required this.username,
    @required this.email,
    this.status,
    this.gender,
    this.age,
    this.desc,
    this.profileImage,
//  List trips,
//  List views,
//  List posts,
//  List likePosts,
//  List followers,
//  List following,
//  List blockLists,
    @required this.followerCount,
    @required this.followingCount,
  });

  factory UserById.fromJson(Map<String, dynamic> parsedJson) {
    return UserById(
      id: parsedJson['user']['id'],
      role: parsedJson['user']['role'],
      diamondCoin: parsedJson['user']['diamondCoin'],
      goldCoin: parsedJson['user']['goldCoin'],
      username: parsedJson['user']['username'],
      email: parsedJson['user']['email'],
      gender: parsedJson['user']['gender'],
      status: parsedJson['user']['status'],
      age: parsedJson['user']['age'],
      desc: parsedJson['user']['desc'],
      profileImage: parsedJson['user']['profileImage'],
      followerCount: parsedJson['user']['followerCount'],
      followingCount: parsedJson['user']['followingCount'],
    );
  }
}
