// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      openId: json['openId'] as String?,
      unionId: json['unionId'] as String?,
      weatherDivination: json['weatherDivination'] as String?,
      terrainDivination: json['terrainDivination'] as String?,
      birthDivination: json['birthDivination'] as String?,
      knotDivination: json['knotDivination'] as String?,
      fortuneDivination: json['fortuneDivination'] as String?,
      birthDate: json['birthDate'] as String?,
      birthTime: (json['birthTime'] as num?)?.toInt(),
      expirationTime: json['expirationTime'] as String?,
      createTime: json['createTime'] as String?,
      isVip: json['payUser'] as bool?,
      phone: json['phone'] as String?,
      wxSessionKey: json['wxSessionKey'] as String?,
      referralCount: (json['referralCount'] as num?)?.toInt() ?? 0,
      referralCode: json['referralCode'] as String?,
      nickName: json['nickName'] as String?,
      firstCode: json['firstCode'] as String?,
      secondCode: json['secondCode'] as String?,
      firstUserId: (json['firstUserId'] as num?)?.toInt(),
      secondUserId: (json['secondUserId'] as num?)?.toInt(),
      promotion: (json['promotion'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'openId': instance.openId,
      'unionId': instance.unionId,
      'weatherDivination': instance.weatherDivination,
      'terrainDivination': instance.terrainDivination,
      'birthDivination': instance.birthDivination,
      'knotDivination': instance.knotDivination,
      'fortuneDivination': instance.fortuneDivination,
      'birthDate': instance.birthDate,
      'birthTime': instance.birthTime,
      'expirationTime': instance.expirationTime,
      'createTime': instance.createTime,
      'payUser': instance.isVip,
      'phone': instance.phone,
      'wxSessionKey': instance.wxSessionKey,
      'referralCount': instance.referralCount,
      'referralCode': instance.referralCode,
      'nickName': instance.nickName,
      'firstCode': instance.firstCode,
      'secondCode': instance.secondCode,
      'firstUserId': instance.firstUserId,
      'secondUserId': instance.secondUserId,
      'promotion': instance.promotion,
      'amount': instance.amount,
    };
