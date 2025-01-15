// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      userInfo: User.fromJson(json['userInfo'] as Map<String, dynamic>),
      terrainDivination: Divination.fromJson(
          json['terrainDivination'] as Map<String, dynamic>),
      knotDivination:
          Divination.fromJson(json['knotDivination'] as Map<String, dynamic>),
      birthDivination:
          Divination.fromJson(json['birthDivination'] as Map<String, dynamic>),
      weatherDivination: Divination.fromJson(
          json['weatherDivination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'userInfo': instance.userInfo,
      'terrainDivination': instance.terrainDivination,
      'knotDivination': instance.knotDivination,
      'birthDivination': instance.birthDivination,
      'weatherDivination': instance.weatherDivination,
    };
