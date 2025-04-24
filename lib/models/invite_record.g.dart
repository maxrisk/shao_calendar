// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteRecord _$InviteRecordFromJson(Map<String, dynamic> json) => InviteRecord(
      id: (json['id'] as num).toInt(),
      phone: json['phone'] as String?,
      dir: json['dir'] as bool?,
      promotion: (json['promotion'] as num?)?.toInt(),
      isPaid: json['payUser'] as bool?,
    );

Map<String, dynamic> _$InviteRecordToJson(InviteRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'dir': instance.dir,
      'promotion': instance.promotion,
      'payUser': instance.isPaid,
    };
