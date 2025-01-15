import 'package:json_annotation/json_annotation.dart';

part 'divination.g.dart';

@JsonSerializable()
class Divination {
  final String? id;
  final String name;
  final String symbol;
  final int sort;
  final String words;
  final String xiangChuan;
  final String tuanChuan;
  final String luck;
  final String? fierce;

  const Divination({
    this.id,
    required this.name,
    required this.symbol,
    required this.sort,
    required this.words,
    required this.xiangChuan,
    required this.tuanChuan,
    required this.luck,
    this.fierce,
  });

  factory Divination.fromJson(Map<String, dynamic> json) =>
      _$DivinationFromJson(json);

  Map<String, dynamic> toJson() => _$DivinationToJson(this);
}
