import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/post/post.dart';

class PostPaging {
  List<Post> posts;
  int take;
  int skip;
  int count;

  PostPaging({
    @required this.posts,
    @required this.take,
    @required this.skip,
    @required this.count,
  });

  factory PostPaging.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['posts'] as List;
    List<Post> postList = list.map((i) => Post.fromJson(i)).toList();
    return PostPaging(
      posts: postList,
      take: parsedJson['take'],
      skip: parsedJson['skip'],
      count: parsedJson['count'],
    );
  }
}
