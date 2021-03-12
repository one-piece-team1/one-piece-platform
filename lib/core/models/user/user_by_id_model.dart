import 'package:flutter/foundation.dart';

class UserById {
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

  factory UserById.fromJson(Map<String, dynamic> responseData) {
    return UserById(
      id: responseData['user']['id'],
      role: responseData['user']['role'],
      diamondCoin: responseData['user']['diamondCoin'],
      goldCoin: responseData['user']['goldCoin'],
      username: responseData['user']['username'],
      email: responseData['user']['email'],
      gender: responseData['user']['gender'],
      status: responseData['user']['status'],
      age: responseData['user']['age'],
      desc: responseData['user']['desc'],
      profileImage: responseData['user']['profileImage'],
      followerCount: responseData['user']['followerCount'],
      followingCount: responseData['user']['followingCount'],
    );
  }
}
