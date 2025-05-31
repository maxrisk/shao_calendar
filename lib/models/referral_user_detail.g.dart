// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral_user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferralUserDetail _$ReferralUserDetailFromJson(Map<String, dynamic> json) =>
    ReferralUserDetail(
      id: (json['id'] as num).toInt(),
      isVip: json['payUser'] as bool,
      phone: json['phone'] as String,
      referralCount: (json['referralCount'] as num).toInt(),
      firstCount: (json['firstCount'] as num).toInt(),
      secondCount: (json['secondCount'] as num).toInt(),
      promotion: (json['promotion'] as num).toInt(),
      areaAgent: (json['areaAgent'] as num).toInt(),
      nickName: json['nickName'] as String?,
    );

Map<String, dynamic> _$ReferralUserDetailToJson(ReferralUserDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payUser': instance.isVip,
      'phone': instance.phone,
      'referralCount': instance.referralCount,
      'firstCount': instance.firstCount,
      'secondCount': instance.secondCount,
      'promotion': instance.promotion,
      'areaAgent': instance.areaAgent,
      'nickName': instance.nickName,
    };
