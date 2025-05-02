// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatPayParams _$WechatPayParamsFromJson(Map<String, dynamic> json) =>
    WechatPayParams(
      appid: json['appid'] as String,
      timestamp: json['timestamp'] as String,
      partnerId: json['partnerId'] as String,
      prepayId: json['prepayId'] as String,
      noncestr: json['noncestr'] as String,
      packageValue: json['packageValue'] as String,
      sign: json['sign'] as String,
    );

Map<String, dynamic> _$WechatPayParamsToJson(WechatPayParams instance) =>
    <String, dynamic>{
      'appid': instance.appid,
      'timestamp': instance.timestamp,
      'partnerId': instance.partnerId,
      'prepayId': instance.prepayId,
      'noncestr': instance.noncestr,
      'packageValue': instance.packageValue,
      'sign': instance.sign,
    };

WechatOrderData _$WechatOrderDataFromJson(Map<String, dynamic> json) =>
    WechatOrderData(
      orderNo: json['orderNo'] as String,
      pay: WechatPayParams.fromJson(json['pay'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WechatOrderDataToJson(WechatOrderData instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'pay': instance.pay,
    };

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
