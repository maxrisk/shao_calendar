// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : OrderData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      orderId: json['orderId'] as String,
      payUrl: json['payUrl'] as String,
      amount: (json['amount'] as num).toInt(),
      productName: json['productName'] as String,
      days: (json['days'] as num).toInt(),
      payType: json['payType'] as String,
    );

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'payUrl': instance.payUrl,
      'amount': instance.amount,
      'productName': instance.productName,
      'days': instance.days,
      'payType': instance.payType,
    };
