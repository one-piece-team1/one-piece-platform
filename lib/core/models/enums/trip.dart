import 'package:json_annotation/json_annotation.dart';

enum ETripView {
  @JsonValue('PUBLIC')
  public,
  @JsonValue('FRIEND')
  friend,
  @JsonValue('SELF')
  self,
}
