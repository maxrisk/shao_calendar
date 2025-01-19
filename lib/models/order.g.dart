// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      payUrl: json['data'] as String?,
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.payUrl,
    };
