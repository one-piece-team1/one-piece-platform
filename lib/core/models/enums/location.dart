import 'package:json_annotation/json_annotation.dart';

enum ELocationType {
  @JsonValue('country')
  COUNTRY,
  @JsonValue('city')
  CITY,
  @JsonValue('scene')
  SCENE,
  @JsonValue('port')
  PORT,
  @JsonValue('turn')
  TURN,
}
