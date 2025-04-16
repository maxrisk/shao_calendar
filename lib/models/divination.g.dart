// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'divination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Divination _$DivinationFromJson(Map<String, dynamic> json) => Divination(
      id: json['id'] as String?,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      sort: (json['sort'] as num).toInt(),
      words: json['words'] as String,
      xiangChuan: json['xiangChuan'] as String,
      tuanChuan: json['tuanChuan'] as String,
      luck: json['luck'] as String,
      fierce: json['fierce'] as String?,
      guide: json['guide'] as String?,
      baziInterpretation: json['baziInterpretation'] as String?,
      lifeInterpretation: json['lifeInterpretation'] as String?,
      deathInterpretation: json['deathInterpretation'] as String?,
    );

Map<String, dynamic> _$DivinationToJson(Divination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'sort': instance.sort,
      'words': instance.words,
      'xiangChuan': instance.xiangChuan,
      'tuanChuan': instance.tuanChuan,
      'luck': instance.luck,
      'fierce': instance.fierce,
      'guide': instance.guide,
      'baziInterpretation': instance.baziInterpretation,
      'lifeInterpretation': instance.lifeInterpretation,
      'deathInterpretation': instance.deathInterpretation,
    };
