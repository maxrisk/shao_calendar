// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ten_year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenYearResponse _$TenYearResponseFromJson(Map<String, dynamic> json) =>
    TenYearResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TenYear.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TenYearResponseToJson(TenYearResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

TenYear _$TenYearFromJson(Map<String, dynamic> json) => TenYear(
      id: TenYear._parseInt(json['id']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      startYear: TenYear._parseInt(json['startYear']),
      endYear: TenYear._parseInt(json['endYear']),
      baseYearId: TenYear._parseInt(json['baseYearId']),
      image: json['image'] as String?,
      divinationName: json['divinationName'] as String?,
      guide: json['guide'] as String?,
    );

Map<String, dynamic> _$TenYearToJson(TenYear instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
      'image': instance.image,
      'baseYearId': instance.baseYearId,
      'divinationName': instance.divinationName,
      'guide': instance.guide,
    };
