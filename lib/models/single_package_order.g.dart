// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_package_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SinglePackageOrderItem _$SinglePackageOrderItemFromJson(
        Map<String, dynamic> json) =>
    SinglePackageOrderItem(
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
    );

Map<String, dynamic> _$SinglePackageOrderItemToJson(
        SinglePackageOrderItem instance) =>
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
    };

SinglePackageOrderListResponse _$SinglePackageOrderListResponseFromJson(
        Map<String, dynamic> json) =>
    SinglePackageOrderListResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => SinglePackageOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SinglePackageOrderListResponseToJson(
        SinglePackageOrderListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
