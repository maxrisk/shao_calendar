// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: (json['id'] as num).toInt(),
      name: json['serviceName'] as String,
      description: json['description'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      originalPrice: (json['originalPrice'] as num?)?.toInt() ?? 0,
      coverImage: json['detailImage'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      benefits: (json['benefits'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      validDays: (json['validDays'] as num?)?.toInt() ?? 0,
      status: Package._isDisplayToStatus(json['isDisplay'] as bool?),
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.name,
      'description': instance.description,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'detailImage': instance.coverImage,
      'images': instance.images,
      'benefits': instance.benefits,
      'validDays': instance.validDays,
      'isDisplay': instance.status,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };

InnerPackageResponse _$InnerPackageResponseFromJson(
        Map<String, dynamic> json) =>
    InnerPackageResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InnerPackageResponseToJson(
        InnerPackageResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

PackageResponse _$PackageResponseFromJson(Map<String, dynamic> json) =>
    PackageResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: PackageResponse._extractInnerData(
          json['data'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$PackageResponseToJson(PackageResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

PackageDetailResponse _$PackageDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PackageDetailResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : Package.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackageDetailResponseToJson(
        PackageDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
