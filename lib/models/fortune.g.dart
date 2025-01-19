// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fortune.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FortuneResponse _$FortuneResponseFromJson(Map<String, dynamic> json) =>
    FortuneResponse(
      code: (json['code'] as num).toInt(),
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : FortuneData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FortuneResponseToJson(FortuneResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

FortuneData _$FortuneDataFromJson(Map<String, dynamic> json) => FortuneData(
      decadeYears: json['decadeYears'] as String,
      thisYear: Divination.fromJson(json['thisYear'] as Map<String, dynamic>),
      decade: Divination.fromJson(json['decade'] as Map<String, dynamic>),
      baseYears: json['baseYears'] as String,
      decadeSymbol: json['decadeSymbol'] as String,
      thisYears: (json['thisYears'] as num).toInt(),
      baseYear: BaseYear.fromJson(json['baseYear'] as Map<String, dynamic>),
      thisSymbol: json['thisSymbol'] as String,
      baseSymbol: json['baseSymbol'] as String,
      dayDivinationInfo: Divination.fromJson(
          json['dayDivinationInfo'] as Map<String, dynamic>),
      decadeName: json['decadeName'] as String,
      yaos: (json['yaos'] as List<dynamic>)
          .map((e) => Yao.fromJson(e as Map<String, dynamic>))
          .toList(),
      solarTerms:
          SolarTerms.fromJson(json['solarTerms'] as Map<String, dynamic>),
      time: (json['time'] as num).toInt(),
      baseName: json['baseName'] as String,
      thisName: json['thisName'] as String,
    );

Map<String, dynamic> _$FortuneDataToJson(FortuneData instance) =>
    <String, dynamic>{
      'decadeYears': instance.decadeYears,
      'thisYear': instance.thisYear,
      'decade': instance.decade,
      'baseYears': instance.baseYears,
      'decadeSymbol': instance.decadeSymbol,
      'thisYears': instance.thisYears,
      'baseYear': instance.baseYear,
      'thisSymbol': instance.thisSymbol,
      'baseSymbol': instance.baseSymbol,
      'dayDivinationInfo': instance.dayDivinationInfo,
      'decadeName': instance.decadeName,
      'yaos': instance.yaos,
      'solarTerms': instance.solarTerms,
      'time': instance.time,
      'baseName': instance.baseName,
      'thisName': instance.thisName,
    };

BaseYear _$BaseYearFromJson(Map<String, dynamic> json) => BaseYear(
      id: json['id'] as String?,
      startYear: (json['startYear'] as num).toInt(),
      endYear: (json['endYear'] as num).toInt(),
      divinationSymbol: json['divinationSymbol'] as String,
      divinationName: json['divinationName'] as String,
      divinationSort: (json['divinationSort'] as num).toInt(),
      firstDecadeStart: (json['firstDecadeStart'] as num).toInt(),
      firstDecadeEnd: (json['firstDecadeEnd'] as num).toInt(),
      secondDecadeStart: (json['secondDecadeStart'] as num).toInt(),
      secondDecadeEnd: (json['secondDecadeEnd'] as num).toInt(),
      thirdDecadeStart: (json['thirdDecadeStart'] as num).toInt(),
      thirdDecadeEnd: (json['thirdDecadeEnd'] as num).toInt(),
      fourthDecadeStart: (json['fourthDecadeStart'] as num).toInt(),
      fourthDecadeEnd: (json['fourthDecadeEnd'] as num).toInt(),
      fifthDecadeStart: (json['fifthDecadeStart'] as num).toInt(),
      fifthDecadeEnd: (json['fifthDecadeEnd'] as num).toInt(),
      sixthDecadeStart: (json['sixthDecadeStart'] as num).toInt(),
      sixthDecadeEnd: (json['sixthDecadeEnd'] as num).toInt(),
    );

Map<String, dynamic> _$BaseYearToJson(BaseYear instance) => <String, dynamic>{
      'id': instance.id,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
      'divinationSymbol': instance.divinationSymbol,
      'divinationName': instance.divinationName,
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

Yao _$YaoFromJson(Map<String, dynamic> json) => Yao(
      id: json['id'] as String?,
      divinationSymbol: json['divinationSymbol'] as String?,
      sort: (json['sort'] as num).toInt(),
      times: json['times'] as String,
      words: json['words'] as String,
      interpret: json['interpret'] as String,
      change: json['change'] as String,
      changeWords: json['changeWords'] as String,
      changeInterpret: json['changeInterpret'] as String,
      determine: json['determine'] as String,
      career: (json['career'] as num).toInt(),
      health: (json['health'] as num).toInt(),
      wealth: (json['wealth'] as num).toInt(),
      emotion: (json['emotion'] as num).toInt(),
      population: (json['population'] as num).toInt(),
    );

Map<String, dynamic> _$YaoToJson(Yao instance) => <String, dynamic>{
      'id': instance.id,
      'divinationSymbol': instance.divinationSymbol,
      'sort': instance.sort,
      'times': instance.times,
      'words': instance.words,
      'interpret': instance.interpret,
      'change': instance.change,
      'changeWords': instance.changeWords,
      'changeInterpret': instance.changeInterpret,
      'determine': instance.determine,
      'career': instance.career,
      'health': instance.health,
      'wealth': instance.wealth,
      'emotion': instance.emotion,
      'population': instance.population,
    };

SolarTerms _$SolarTermsFromJson(Map<String, dynamic> json) => SolarTerms(
      id: json['id'] as String?,
      year: json['year'] as String?,
      lastWinterSolstice: json['lastWinterSolstice'] as String,
      winterSolstice: json['winterSolstice'] as String,
      rainWater: json['rainWater'] as String,
      grainRain: json['grainRain'] as String,
      summerSolstice: json['summerSolstice'] as String,
      endOfHeat: json['endOfHeat'] as String,
      frostDescent: json['frostDescent'] as String,
      dayAfterLastWinterSolstice: json['dayAfterLastWinterSolstice'] as String,
      dayAfterWinterSolstice: json['dayAfterWinterSolstice'] as String,
      dayAfterRainWater: json['dayAfterRainWater'] as String,
      dayAfterGrainRain: json['dayAfterGrainRain'] as String,
      dayAfterSummerSolstice: json['dayAfterSummerSolstice'] as String,
      dayAfterEndOfHeat: json['dayAfterEndOfHeat'] as String,
      dayAfterFrostDescent: json['dayAfterFrostDescent'] as String,
    );

Map<String, dynamic> _$SolarTermsToJson(SolarTerms instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'lastWinterSolstice': instance.lastWinterSolstice,
      'winterSolstice': instance.winterSolstice,
      'rainWater': instance.rainWater,
      'grainRain': instance.grainRain,
      'summerSolstice': instance.summerSolstice,
      'endOfHeat': instance.endOfHeat,
      'frostDescent': instance.frostDescent,
      'dayAfterLastWinterSolstice': instance.dayAfterLastWinterSolstice,
      'dayAfterWinterSolstice': instance.dayAfterWinterSolstice,
      'dayAfterRainWater': instance.dayAfterRainWater,
      'dayAfterGrainRain': instance.dayAfterGrainRain,
      'dayAfterSummerSolstice': instance.dayAfterSummerSolstice,
      'dayAfterEndOfHeat': instance.dayAfterEndOfHeat,
      'dayAfterFrostDescent': instance.dayAfterFrostDescent,
    };
