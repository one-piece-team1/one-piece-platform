import 'package:one_piece_platform/core/models/common/base.dart';
import 'package:one_piece_platform/core/models/enums/trip.dart';
import 'package:one_piece_platform/core/models/trip/trip.dart';
import 'package:one_piece_platform/core/models/user/user_by_id_model.dart';

class Post extends Base {
  String id;
  String content;
  ETripView publicStatus;
  UserById publisher;
  List<UserById> likeUsers;
  Trip trip;

  Post({
    this.id,
    this.content,
    this.publicStatus,
    this.publisher,
    this.likeUsers,
    this.trip,
  });

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return Post(
        id: parsedJson['id'],
        content: parsedJson['content'],
        publicStatus: parsedJson['publicStatus'],
        publisher: parsedJson['publisher'],
        likeUsers: parsedJson['likeUsers'],
        trip: parsedJson['trip']);
  }
}
