// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawRecord _$WithdrawRecordFromJson(Map<String, dynamic> json) =>
    WithdrawRecord(
      id: (json['id'] as num).toInt(),
      createBy: json['createBy'] as String?,
      createTime: json['createTime'] as String,
      updateBy: json['updateBy'] as String?,
      updateTime: json['updateTime'] as String?,
      remark: json['remark'] as String?,
      nowAmount: (json['nowAmount'] as num).toDouble(),
      preAmount: (json['preAmount'] as num).toDouble(),
      changeAmount: (json['changeAmount'] as num).toDouble(),
      userId: (json['userId'] as num).toInt(),
      linkUserId: (json['linkUserId'] as num?)?.toInt(),
      orderNo: json['orderNo'] as String,
      promotion: (json['promotion'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$WithdrawRecordToJson(WithdrawRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'remark': instance.remark,
      'nowAmount': instance.nowAmount,
      'preAmount': instance.preAmount,
      'changeAmount': instance.changeAmount,
      'userId': instance.userId,
      'linkUserId': instance.linkUserId,
      'orderNo': instance.orderNo,
      'promotion': instance.promotion,
      'level': instance.level,
      'type': instance.type,
      'name': instance.name,
    };

WithdrawRecordListResponse _$WithdrawRecordListResponseFromJson(
        Map<String, dynamic> json) =>
    WithdrawRecordListResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WithdrawRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WithdrawRecordListResponseToJson(
        WithdrawRecordListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
