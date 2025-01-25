// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      payType: json['payType'] as String,
      orderNo: json['orderNo'] as String,
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      createTime: json['createTime'] as String,
      expireTime: json['expireTime'] as String?,
      payedTime: json['payedTime'] as String?,
      title: json['title'] as String?,
      firstAmount: (json['firstAmount'] as num).toDouble(),
      secondAmount: (json['secondAmount'] as num).toDouble(),
      firstUserId: (json['firstUserId'] as num?)?.toInt(),
      secondUserId: (json['secondUserId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'payType': instance.payType,
      'orderNo': instance.orderNo,
      'total': instance.total,
      'status': instance.status,
      'createTime': instance.createTime,
      'expireTime': instance.expireTime,
      'payedTime': instance.payedTime,
      'title': instance.title,
      'firstAmount': instance.firstAmount,
      'secondAmount': instance.secondAmount,
      'firstUserId': instance.firstUserId,
      'secondUserId': instance.secondUserId,
      'productId': instance.productId,
    };

OrderListResponse _$OrderListResponseFromJson(Map<String, dynamic> json) =>
    OrderListResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderListResponseToJson(OrderListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
