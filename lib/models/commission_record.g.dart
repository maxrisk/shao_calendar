// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionRecord _$CommissionRecordFromJson(Map<String, dynamic> json) =>
    CommissionRecord(
      id: (json['id'] as num).toInt(),
      createTime: json['createTime'] as String?,
      remark: json['remark'] as String?,
      nowAmount: (json['nowAmount'] as num).toDouble(),
      preAmount: (json['preAmount'] as num).toDouble(),
      changeAmount: (json['changeAmount'] as num).toDouble(),
      userId: (json['userId'] as num).toInt(),
      linkUserId: (json['linkUserId'] as num?)?.toInt(),
      orderNo: json['orderNo'] as String,
      promotion: (json['promotion'] as num).toInt(),
      level: $enumDecode(_$CommissionRecordTypeEnumMap, json['level'],
          unknownValue: CommissionRecordType.direct),
      type: (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$CommissionRecordToJson(CommissionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'remark': instance.remark,
      'nowAmount': instance.nowAmount,
      'preAmount': instance.preAmount,
      'changeAmount': instance.changeAmount,
      'userId': instance.userId,
      'linkUserId': instance.linkUserId,
      'orderNo': instance.orderNo,
      'promotion': instance.promotion,
      'level': _$CommissionRecordTypeEnumMap[instance.level]!,
      'type': instance.type,
    };

const _$CommissionRecordTypeEnumMap = {
  CommissionRecordType.withdraw: 0,
  CommissionRecordType.direct: 1,
  CommissionRecordType.indirect: 2,
};
