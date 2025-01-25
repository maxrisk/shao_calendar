import 'package:json_annotation/json_annotation.dart';
import 'divination.dart';

part 'fortune.g.dart';

@JsonSerializable()
class FortuneResponse {
  final int code;
  final String? msg;
  final FortuneData? data;

  FortuneResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory FortuneResponse.fromJson(Map<String, dynamic> json) =>
      _$FortuneResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FortuneResponseToJson(this);
}

@JsonSerializable()
class FortuneData {
  final String decadeYears;
  final Divination thisYear;
  final Divination decade;
  final String baseYears;
  final String decadeSymbol;
  final String thisYears;
  final BaseYear baseYear;
  final String thisSymbol;
  final String baseSymbol;
  final Divination dayDivinationInfo;
  final String decadeName;
  final List<Yao> yaos;
  final SolarTerms solarTerms;
  final int time;
  final String baseName;
  final String thisName;

  const FortuneData({
    required this.decadeYears,
    required this.thisYear,
    required this.decade,
    required this.baseYears,
    required this.decadeSymbol,
    required this.thisYears,
    required this.baseYear,
    required this.thisSymbol,
    required this.baseSymbol,
    required this.dayDivinationInfo,
    required this.decadeName,
    required this.yaos,
    required this.solarTerms,
    required this.time,
    required this.baseName,
    required this.thisName,
  });

  factory FortuneData.fromJson(Map<String, dynamic> json) =>
      _$FortuneDataFromJson(json);

  Map<String, dynamic> toJson() => _$FortuneDataToJson(this);
}

@JsonSerializable()
class BaseYear {
  final String? id;
  final int startYear;
  final int endYear;
  final String divinationSymbol;
  final String divinationName;
  final int divinationSort;
  final int firstDecadeStart;
  final int firstDecadeEnd;
  final int secondDecadeStart;
  final int secondDecadeEnd;
  final int thirdDecadeStart;
  final int thirdDecadeEnd;
  final int fourthDecadeStart;
  final int fourthDecadeEnd;
  final int fifthDecadeStart;
  final int fifthDecadeEnd;
  final int sixthDecadeStart;
  final int sixthDecadeEnd;

  BaseYear({
    this.id,
    required this.startYear,
    required this.endYear,
    required this.divinationSymbol,
    required this.divinationName,
    required this.divinationSort,
    required this.firstDecadeStart,
    required this.firstDecadeEnd,
    required this.secondDecadeStart,
    required this.secondDecadeEnd,
    required this.thirdDecadeStart,
    required this.thirdDecadeEnd,
    required this.fourthDecadeStart,
    required this.fourthDecadeEnd,
    required this.fifthDecadeStart,
    required this.fifthDecadeEnd,
    required this.sixthDecadeStart,
    required this.sixthDecadeEnd,
  });

  factory BaseYear.fromJson(Map<String, dynamic> json) =>
      _$BaseYearFromJson(json);
  Map<String, dynamic> toJson() => _$BaseYearToJson(this);
}

@JsonSerializable()
class Yao {
  final String? id;
  final String? divinationSymbol;
  final int sort;
  final String times;
  final String words;
  final String interpret;
  final String change;
  final String changeWords;
  final String changeInterpret;
  final String determine;
  final String personalTheme;
  final String personalComment;
  final String personalStrategy;
  final int career;
  final int health;
  final int wealth;
  final int emotion;
  final int population;
  final String personalSummary;

  Yao({
    this.id,
    this.divinationSymbol,
    required this.sort,
    required this.times,
    required this.words,
    required this.interpret,
    required this.change,
    required this.changeWords,
    required this.changeInterpret,
    required this.determine,
    required this.career,
    required this.health,
    required this.wealth,
    required this.emotion,
    required this.population,
    required this.personalSummary,
    required this.personalTheme,
    required this.personalComment,
    required this.personalStrategy,
  });

  factory Yao.fromJson(Map<String, dynamic> json) => _$YaoFromJson(json);
  Map<String, dynamic> toJson() => _$YaoToJson(this);
}

@JsonSerializable()
class SolarTerms {
  final String? id;
  final String? year;
  final String lastWinterSolstice;
  final String winterSolstice;
  final String rainWater;
  final String grainRain;
  final String summerSolstice;
  final String endOfHeat;
  final String frostDescent;
  final String dayAfterLastWinterSolstice;
  final String dayAfterWinterSolstice;
  final String dayAfterRainWater;
  final String dayAfterGrainRain;
  final String dayAfterSummerSolstice;
  final String dayAfterEndOfHeat;
  final String dayAfterFrostDescent;

  SolarTerms({
    this.id,
    this.year,
    required this.lastWinterSolstice,
    required this.winterSolstice,
    required this.rainWater,
    required this.grainRain,
    required this.summerSolstice,
    required this.endOfHeat,
    required this.frostDescent,
    required this.dayAfterLastWinterSolstice,
    required this.dayAfterWinterSolstice,
    required this.dayAfterRainWater,
    required this.dayAfterGrainRain,
    required this.dayAfterSummerSolstice,
    required this.dayAfterEndOfHeat,
    required this.dayAfterFrostDescent,
  });

  factory SolarTerms.fromJson(Map<String, dynamic> json) =>
      _$SolarTermsFromJson(json);
  Map<String, dynamic> toJson() => _$SolarTermsToJson(this);
}
