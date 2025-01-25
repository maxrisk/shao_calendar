import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int? id;
  final int? year;
  final String name;
  final String? description;
  final double price;
  final String? createTime;
  final String? updateTime;
  final int? type;
  final double? firstAmount;
  final double? secondAmount;
  final double? provinceAmount;
  final double? cityAmount;
  @JsonKey(name: 'day')
  final int days;

  const Product({
    this.id,
    this.year,
    required this.name,
    this.description,
    required this.price,
    this.createTime,
    this.updateTime,
    this.type,
    this.firstAmount,
    this.secondAmount,
    this.provinceAmount,
    this.cityAmount,
    required this.days,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductResponse {
  final int code;
  final String? msg;
  final Product? data;

  const ProductResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
