// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      year: (json['year'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      type: (json['type'] as num?)?.toInt(),
      firstAmount: (json['firstAmount'] as num?)?.toDouble(),
      secondAmount: (json['secondAmount'] as num?)?.toDouble(),
      provinceAmount: (json['provinceAmount'] as num?)?.toDouble(),
      cityAmount: (json['cityAmount'] as num?)?.toDouble(),
      days: (json['day'] as num).toInt(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'type': instance.type,
      'firstAmount': instance.firstAmount,
      'secondAmount': instance.secondAmount,
      'provinceAmount': instance.provinceAmount,
      'cityAmount': instance.cityAmount,
      'day': instance.days,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : Product.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
