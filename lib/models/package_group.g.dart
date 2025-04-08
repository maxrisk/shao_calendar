// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageGroup _$PackageGroupFromJson(Map<String, dynamic> json) => PackageGroup(
      id: (json['id'] as num).toInt(),
      name: json['packageName'] as String,
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
      status: PackageGroup._isDisplayToStatus(json['isDisplay'] as bool?),
      packages: (json['singleServices'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      relatedServiceIds: json['relatedServiceIds'] as String?,
    );

Map<String, dynamic> _$PackageGroupToJson(PackageGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageName': instance.name,
      'description': instance.description,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'detailImage': instance.coverImage,
      'images': instance.images,
      'benefits': instance.benefits,
      'validDays': instance.validDays,
      'isDisplay': instance.status,
      'singleServices': instance.packages,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'relatedServiceIds': instance.relatedServiceIds,
    };

InnerPackageGroupResponse _$InnerPackageGroupResponseFromJson(
        Map<String, dynamic> json) =>
    InnerPackageGroupResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PackageGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InnerPackageGroupResponseToJson(
        InnerPackageGroupResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

PackageGroupResponse _$PackageGroupResponseFromJson(
        Map<String, dynamic> json) =>
    PackageGroupResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: PackageGroupResponse._extractInnerData(
          json['data'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$PackageGroupResponseToJson(
        PackageGroupResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

PackageGroupDetailResponse _$PackageGroupDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PackageGroupDetailResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : PackageGroup.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackageGroupDetailResponseToJson(
        PackageGroupDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
