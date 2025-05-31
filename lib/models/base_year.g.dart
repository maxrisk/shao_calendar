// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_year.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseYearResponse _$BaseYearResponseFromJson(Map<String, dynamic> json) =>
    BaseYearResponse(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BaseYear.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaseYearResponseToJson(BaseYearResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

BaseYear _$BaseYearFromJson(Map<String, dynamic> json) => BaseYear(
      id: BaseYear._parseInt(json['id']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      startYear: BaseYear._parseInt(json['startYear']),
      endYear: BaseYear._parseInt(json['endYear']),
      image: json['image'] as String?,
      divinationName: json['divinationName'] as String?,
      guide: json['guide'] as String?,
      divinationSymbol: json['divinationSymbol'] as String?,
      divinationSort: BaseYear._parseInt(json['divinationSort']),
      firstDecadeStart: BaseYear._parseInt(json['firstDecadeStart']),
      firstDecadeEnd: BaseYear._parseInt(json['firstDecadeEnd']),
      secondDecadeStart: BaseYear._parseInt(json['secondDecadeStart']),
      secondDecadeEnd: BaseYear._parseInt(json['secondDecadeEnd']),
      thirdDecadeStart: BaseYear._parseInt(json['thirdDecadeStart']),
      thirdDecadeEnd: BaseYear._parseInt(json['thirdDecadeEnd']),
      fourthDecadeStart: BaseYear._parseInt(json['fourthDecadeStart']),
      fourthDecadeEnd: BaseYear._parseInt(json['fourthDecadeEnd']),
      fifthDecadeStart: BaseYear._parseInt(json['fifthDecadeStart']),
      fifthDecadeEnd: BaseYear._parseInt(json['fifthDecadeEnd']),
      sixthDecadeStart: BaseYear._parseInt(json['sixthDecadeStart']),
      sixthDecadeEnd: BaseYear._parseInt(json['sixthDecadeEnd']),
    );

Map<String, dynamic> _$BaseYearToJson(BaseYear instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
      'image': instance.image,
      'divinationName': instance.divinationName,
      'guide': instance.guide,
      'divinationSymbol': instance.divinationSymbol,
      'divinationSort': instance.divinationSort,
      'firstDecadeStart': instance.firstDecadeStart,
      'firstDecadeEnd': instance.firstDecadeEnd,
      'secondDecadeStart': instance.secondDecadeStart,
      'secondDecadeEnd': instance.secondDecadeEnd,
      'thirdDecadeStart': instance.thirdDecadeStart,
      'thirdDecadeEnd': instance.thirdDecadeEnd,
      'fourthDecadeStart': instance.fourthDecadeStart,
      'fourthDecadeEnd': instance.fourthDecadeEnd,
      'fifthDecadeStart': instance.fifthDecadeStart,
      'fifthDecadeEnd': instance.fifthDecadeEnd,
      'sixthDecadeStart': instance.sixthDecadeStart,
      'sixthDecadeEnd': instance.sixthDecadeEnd,
    };
