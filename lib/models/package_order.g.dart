// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageOrderDetailItem _$PackageOrderDetailItemFromJson(
        Map<String, dynamic> json) =>
    PackageOrderDetailItem(
      id: (json['id'] as num).toInt(),
      serviceName: json['serviceName'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      detailImage: json['detailImage'] as String,
      packageOrderId: (json['packageOrderId'] as num).toInt(),
      createTime: json['createTime'] as String,
    );

Map<String, dynamic> _$PackageOrderDetailItemToJson(
        PackageOrderDetailItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.serviceName,
      'price': instance.price,
      'description': instance.description,
      'detailImage': instance.detailImage,
      'packageOrderId': instance.packageOrderId,
      'createTime': instance.createTime,
    };

PackageOrderItem _$PackageOrderItemFromJson(Map<String, dynamic> json) =>
    PackageOrderItem(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      payType: json['payType'] as String,
      orderNo: json['orderNo'] as String,
      createTime: json['createTime'] as String,
      updateTime: json['updateTime'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      packageId: (json['packageId'] as num).toInt(),
      name: json['name'] as String,
      total: (json['total'] as num).toDouble(),
      description: json['description'] as String,
      detailImage: json['detailImage'] as String,
      details: (json['details'] as List<dynamic>)
          .map(
              (e) => PackageOrderDetailItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageOrderItemToJson(PackageOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'payType': instance.payType,
      'orderNo': instance.orderNo,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'status': instance.status,
      'type': instance.type,
      'packageId': instance.packageId,
      'name': instance.name,
      'total': instance.total,
      'description': instance.description,
      'detailImage': instance.detailImage,
      'details': instance.details,
    };

PackageOrderListResponse _$PackageOrderListResponseFromJson(
        Map<String, dynamic> json) =>
    PackageOrderListResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PackageOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageOrderListResponseToJson(
        PackageOrderListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
