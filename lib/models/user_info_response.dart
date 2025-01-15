import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
import 'divination.dart';

part 'user_info_response.g.dart';

@JsonSerializable()
class UserInfoResponse {
  final User userInfo;
  final Divination terrainDivination;
  final Divination knotDivination;
  final Divination birthDivination;
  final Divination weatherDivination;

  const UserInfoResponse({
    required this.userInfo,
    required this.terrainDivination,
    required this.knotDivination,
    required this.birthDivination,
    required this.weatherDivination,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}
