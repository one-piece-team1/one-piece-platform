import 'package:json_annotation/json_annotation.dart';

enum EUserRole {
  @JsonValue('TRIAL')
  trial,
  @JsonValue('USER')
  user,
  @JsonValue('VIP1')
  vip1,
  @JsonValue('VIP2')
  vip2,
  @JsonValue('ADMIN')
  admin,
}

enum EUserGender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female
}
